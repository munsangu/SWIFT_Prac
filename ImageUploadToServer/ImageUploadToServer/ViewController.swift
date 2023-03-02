import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    var selectedImage = UIImage()
    var selectedImageName: String = ""
    var selectedImageType: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imageView.backgroundColor = .brown
    }
    
    @IBAction func cameraBTN(_ sender: UIButton) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true)
    }
    
    @IBAction func photoBTN(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    @IBAction func clearBTN(_ sender: UIButton) {
        selectedImage = UIImage()
        imageView.image = UIImage()
    }
    
    @IBAction func sendBTN(_ sender: UIButton) {
        let imageData = selectedImage.jpegData(compressionQuality: 1.0)! as Data
        uploadImage(imageData: imageData)
    }
    
    private func uploadImage(imageData: Data) {
        let urlString = "https://wkwebview-awugh.run.goorm.site/imgUpload.php"
        let session = URLSession.shared
        guard let url = URL(string: urlString) else { return }
        
        // HTTP POST 요청 생성
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // HTTP 요청 body 생성
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let httpBody = NSMutableData()

        // 이미지 바이너리 데이터 생성
        let name = selectedImageName
        let type = selectedImageType
        httpBody.append("--\(boundary)\r\n".data(using: .utf8)!)
        httpBody.append("Content-Disposition: form-data; name=\"uploads\"; filename=\"\(name)\"\r\n".data(using: .utf8)!)
        httpBody.append("Content-Type: \(type)\r\n\r\n".data(using: .utf8)!)
        httpBody.append(imageData)
        httpBody.append("\r\n".data(using: .utf8)!)
        
        // HTTP 요청 생성
        request.httpBody = httpBody as Data
        
        // HTTP 요청 전송
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error.localizedDescription)")
                return
            }
            
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("response: \(responseString)")
            } else {
                print("Invalid response")
            }
        }
        task.resume()
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, URLSessionDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        guard let imageUrl = info[.imageURL] as? URL else { return }
        selectedImageName = imageUrl.lastPathComponent
        selectedImageType = imageUrl.pathExtension
        //        print("Selected ImageName: \(selectedImageName), Selected ImageType: \(selectedImageType)")
        selectedImage = img
        imageView.image = img
        imageView.backgroundColor = .clear
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}
