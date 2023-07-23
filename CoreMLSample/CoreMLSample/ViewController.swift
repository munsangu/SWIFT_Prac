import UIKit
import CoreML
import TensorFlowLite

class ViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Select Image"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        view.addSubview(imageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        tap.numberOfTapsRequired = 1
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.frame = CGRect(x: 20, y: view.safeAreaInsets.top, width: view.frame.size.width - 40, height: view.frame.size.width - 40)
        label.frame = CGRect(x: 20, y: view.safeAreaInsets.top + (view.frame.size.width - 40) + 10, width: view.frame.size.width - 40, height: 100)
    }
    
    @objc func didTapImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    private func analyzeImage(image: UIImage?) {
        guard let buffer = image?.resize(size: CGSize(width: 224, height: 224))?
            .getCVPixelBuffer() else {
            return
        }
        do {
            // Load your custom tflite model here
            if let modelPath = Bundle.main.path(forResource: "model_edgetpu", ofType: "tflite") {
                let model = try Interpreter(modelPath: modelPath)
                
                // Allocate input and output tensors (assuming your model has only 1 input and 1 output)
                try model.allocateTensors()
                
                // Preprocess the input data (modify this part according to your custom model's input requirements)
                // Here, we assume your model takes a single 224x224 RGB image as input
                let inputTensor = try model.input(at: 0)
                try inputTensor.copy(from: buffer.data)
                
                // Run inference
                try model.invoke()
                
                // Read the output tensor (modify this part according to your custom model's output)
                let outputTensor = try model.output(at: 0)
                let outputData = [Float32](unsafeData: outputTensor.data) // Modify the data type if needed
                
                // Process the output data (modify this part according to your custom model's output)
                // Here, we assume the output is a label index (an integer)
                let predictedLabelIndex = outputData.argmax()
                let text = "Label: \(predictedLabelIndex)"
                label.text = text
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        //        do {
        //            let config = MLModelConfiguration()
        //            let model = try GoogLeNetPlaces(configuration: config)
        //            let input = GoogLeNetPlacesInput(sceneImage: buffer)
        //
        //            let output = try model.prediction(input: input)
        //            let text = output.sceneLabel
        //            label.text = text
        //        } catch {
        //            print("Error: \(error.localizedDescription)")
        //        }
    }
    
}

extension UIImage {
    /// Resize image
    /// - Parameter size: Size to resize to
    /// - Returns: Resized image
    func resize(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// Create and return CoreVideo Pixel Buffer
    /// - Returns: Pixel Buffer
    func getCVPixelBuffer() -> CVPixelBuffer? {
        guard let image = cgImage else {
            return nil
        }
        let imageWidth = Int(image.width)
        let imageHeight = Int(image.height)
        
        let attributes : [NSObject:AnyObject] = [
            kCVPixelBufferCGImageCompatibilityKey : true as AnyObject,
            kCVPixelBufferCGBitmapContextCompatibilityKey : true as AnyObject
        ]
        
        var pxbuffer: CVPixelBuffer? = nil
        CVPixelBufferCreate(
            kCFAllocatorDefault,
            imageWidth,
            imageHeight,
            kCVPixelFormatType_32ARGB,
            attributes as CFDictionary?,
            &pxbuffer
        )
        
        if let _pxbuffer = pxbuffer {
            let flags = CVPixelBufferLockFlags(rawValue: 0)
            CVPixelBufferLockBaseAddress(_pxbuffer, flags)
            let pxdata = CVPixelBufferGetBaseAddress(_pxbuffer)
            
            let rgbColorSpace = CGColorSpaceCreateDeviceRGB();
            let context = CGContext(
                data: pxdata,
                width: imageWidth,
                height: imageHeight,
                bitsPerComponent: 8,
                bytesPerRow: CVPixelBufferGetBytesPerRow(_pxbuffer),
                space: rgbColorSpace,
                bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue
            )
            
            if let _context = context {
                _context.draw(
                    image,
                    in: CGRect.init(
                        x: 0,
                        y: 0,
                        width: imageWidth,
                        height: imageHeight
                    )
                )
            }
            else {
                CVPixelBufferUnlockBaseAddress(_pxbuffer, flags);
                return nil
            }
            
            CVPixelBufferUnlockBaseAddress(_pxbuffer, flags);
            return _pxbuffer;
        }
        
        return nil
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        imageView.image = image
        analyzeImage(image: image)
    }
    
}

extension ViewController: UINavigationControllerDelegate {
    
}
