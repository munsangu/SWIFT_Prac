import UIKit
import CoreML

class ViewController: UIViewController {
    
    let userNickname = UserDefaults.standard.string(forKey: "userNickname")
    
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
        
        imageView.frame = CGRect(x: 20, y: view.safeAreaInsets.top, width: view.frame.size.width - 40, height: view.frame.size.width - 40)
        label.frame = CGRect(x: 20, y: view.safeAreaInsets.top + (view.frame.size.width - 40) + 10, width: view.frame.size.width - 40, height: 100)
                
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        tap.numberOfTapsRequired = 1
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }
    
    @objc func didTapImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    private func analyzeImage(image: UIImage?) {
        guard let buffer = image?.resize(size: CGSize(width: 299, height: 299))?
            .getCVPixelBuffer() else {
            return
        }
        
        do {
            let config = MLModelConfiguration()
            let model = try NeckDetector(configuration: config)
            let input = NeckDetectorInput(image: buffer)

            let output = try model.prediction(input: input)
            let text = output.classLabel
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 2
            
            var percentageDecimal: [String: Double] = [:]
            for (className, probability) in output.classLabelProbs {
                if let probabilityDecimal = formatter.number(from: "\(probability)")?.doubleValue {
                    percentageDecimal[className] = probabilityDecimal
                }
            }
            
            label.text = text
            UserDefaults.standard.set(text, forKey: "turtleLabel")
            let multipleNumber = percentageDecimal[text]! * 100
            let turnNumber = floor(multipleNumber) / 100
            UserDefaults.standard.set(turnNumber, forKey: "turtlePercentage")
            presentResultOfTurtleViewController()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    private func presentResultOfTurtleViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let resultOfTurtleViewController = storyboard.instantiateViewController(withIdentifier: "resultOfTurtleViewController") as? ResultOfTurtleViewController else {
            return
        }
        resultOfTurtleViewController.modalPresentationStyle = .fullScreen
        self.present(resultOfTurtleViewController, animated: true)
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
        analyzeImage(image: image)
    }
    
}

extension ViewController: UINavigationControllerDelegate {
    
}
