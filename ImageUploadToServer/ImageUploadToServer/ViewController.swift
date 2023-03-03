import UIKit
//import AVFoundation
import MobileCoreServices

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    var selectedImage = UIImage()
    var selectedImageName: String = ""
    var selectedImageType: String = ""
    
    // camera (AVCaptureSession, AVCaptureDeviceInput, AVCapturePhotoOutput, AVCaptureVideoPreviewLayer 객체 생성)
    //    let session = AVCaptureSession()
    //    var device: AVCaptureDevice!
    //    var input: AVCaptureInput!
    //    let output = AVCapturePhotoOutput()
    //    var previewLayer: AVCaptureVideoPreviewLayer!
    // camera (AVCaptureSession, AVCaptureDeviceInput, AVCapturePhotoOutput, AVCaptureVideoPreviewLayer 객체 생성)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        imageView.backgroundColor = .lightGray
        
    }
    
    @IBAction func cameraBTN(_ sender: UIButton) {
        
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
            
        } else {
            
            myAlert("Camera inaccessable", message: "Application cannot access the camera.")
            
        }
        
    }
    
    // AVCaptureSession을 사용하여 카메라에 액세스 (버튼을 클릭하면 바로 촬영하는 코드) -> QR Code 카메라로 활용 가능???
    //        do {
    //            device = AVCaptureDevice.default(for: .video)
    //            input = try AVCaptureDeviceInput(device: device)
    //            session.addInput(input)
    //            session.addOutput(output)
    //            previewLayer = AVCaptureVideoPreviewLayer(session: session)
    //            previewLayer.videoGravity = .resizeAspectFill
    //            previewLayer.connection?.videoOrientation = .portrait
    //            imageView.layer.addSublayer(previewLayer)
    //            session.startRunning()
    //        } catch {
    //            print(error)
    //        }
    //
    //        let settings = AVCapturePhotoSettings()
    //        output.capturePhoto(with: settings, delegate: self)
    //    }
    //
    //    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
    //        if let error = error {
    //            print("ERROR: \(error.localizedDescription)")
    //            return
    //        }
    //        guard let imageData = photo.fileDataRepresentation(), let image = UIImage(data: imageData) else {
    //            print("ERROR getting image data")
    //            return
    //        }
    //        imageView.image = image
    //        imageView.backgroundColor = .clear
    //        selectedImage = image
    //    }
    // AVCaptureSession을 사용하여 카메라에 액세스 (버튼을 클릭하면 바로 촬영하는 코드)
    
    @IBAction func photoBTN(_ sender: UIButton) {
        
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
            
        } else {
            
            myAlert("Photo album inaccessable", message: "Application cannot access the photo albm.")
            
        }
        
    }
    
    @IBAction func clearBTN(_ sender: UIButton) {
        
        selectedImage = UIImage()
        selectedImageName = ""
        selectedImageType = ""
        imageView.image = UIImage()
        imageView.backgroundColor = .lightGray
        
    }
    
    @IBAction func sendBTN(_ sender: UIButton) {
        
        uploadImage(image: selectedImage)
        
    }
    
    private func myAlert(_ title: String,message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // 서버에 이미지를 업로드하는 함수
    private func uploadImage(image: UIImage) {
        
        let url = URL(string: "https://wkwebview-awugh.run.goorm.site/imgUpload.php")!
        
        // 이미지를 JPEG 데이터로 변환
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            
            print("Failed to convert image to JPEG data")
            return
            
        }
        
        // URLRequest 생성
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // HTTP Body에 이미지 데이터 추가
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let httpBody = NSMutableData()
        httpBody.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        httpBody.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(selectedImageName)\"\r\n".data(using: String.Encoding.utf8)!)
        httpBody.append("Content-Type: image/\(selectedImageType)\r\n\r\n".data(using: String.Encoding.utf8)!)
        httpBody.append(imageData)
        httpBody.append("\r\n".data(using: String.Encoding.utf8)!)
        httpBody.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        request.httpBody = httpBody as Data
        
        // URLSession을 사용하여 서버에 요청
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Invaild response")
                return
            }
            print("Status code: \(response.statusCode)")
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }
        }
        task.resume()
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, URLSessionDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        guard let captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String) {
            
            if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
                
                let imgName = UUID().uuidString+".jpeg"
                let documentDirectory = NSTemporaryDirectory()
                let localPath = documentDirectory.appending(imgName)
                let data = captureImage.jpegData(compressionQuality: 0.3)! as NSData
                data.write(toFile: localPath, atomically: true)
                let photoURL = URL.init(fileURLWithPath: localPath)
                selectedImageName = photoURL.lastPathComponent
                selectedImageType = photoURL.pathExtension
                print("Selected ImageName: \(selectedImageName), Selected ImageType: \(selectedImageType)")
                selectedImage = captureImage
                imageView.image = captureImage
                imageView.backgroundColor = .clear
                
            } else if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
                
                guard let imageUrl = info[.imageURL] as? URL else { return }
                selectedImageName = imageUrl.lastPathComponent
                selectedImageType = imageUrl.pathExtension
                print("Selected ImageName: \(selectedImageName), Selected ImageType: \(selectedImageType)")
                selectedImage = captureImage
                imageView.image = captureImage
                imageView.backgroundColor = .clear
                
            } // Choose File 클릭 시 Logic 필요
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true)
        
    }
    
}
