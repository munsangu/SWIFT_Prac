import UIKit
import WebKit
import Alamofire
import MobileCoreServices

class ViewController: UIViewController, WKUIDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, WKScriptMessageHandler  {
    
    var webView: WKWebView!
    
    override func loadView() {
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        
        // ====== webview scroll bounce control ======
        webView.scrollView.alwaysBounceVertical = false
        webView.scrollView.bounces = false
        // ====== webview scroll bounce control ======
        
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webViewSetting()
    }
    
    private func webViewSetting() {
        webView.backgroundColor = UIColor(red: 34 / 255, green: 34 / 255, blue: 34 / 255, alpha: 1.0)
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        webView.evaluateJavaScript("showImagePicker()")
        
        let contentController = webView.configuration.userContentController
        contentController.add(self, name: "inputTest")
        
        // Alamofire로 URLRequest 생성 및 로딩
        let url = "https://wkwebview-awugh.run.goorm.site/"
        let request = try! MyURLRequestConvertible(urlString: url).asURLRequest()
        webView.load(request)
        
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                print("\(cookie.name) : \(cookie.value)")
            }
        }
        
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("Received Message: \(message)")
    }
    
    func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary // 또는 .camera
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        guard message.contains("Choose File") else {
            completionHandler()
            return
        }
        
        print("MSG: \(message)")
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String]
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            imagePicker.modalPresentationStyle = .popover
            imagePicker.popoverPresentationController?.sourceRect = CGRect(x: webView.bounds.midX, y: webView.bounds.midY, width: 0, height: 0)
            imagePicker.popoverPresentationController?.sourceView = webView
            imagePicker.popoverPresentationController?.permittedArrowDirections = []
            present(imagePicker, animated: true, completion: nil)
        } else {
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.navigationType == .formResubmitted || navigationAction.navigationType == .formSubmitted {
            guard let httpBodyStream = navigationAction.request.httpBodyStream else { return nil }
            var data = Data()
            let bufferSize = 1024
            let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
            httpBodyStream.open()
            while httpBodyStream.hasBytesAvailable {
                let readCount = httpBodyStream.read(buffer, maxLength: bufferSize)
                if readCount > 0 {
                    data.append(buffer, count: readCount)
                } else if readCount < 0 {
                    httpBodyStream.close()
                    buffer.deallocate()
                    return nil
                } else {
                    break
                }
            }
            httpBodyStream.close()
            buffer.deallocate()
            let string = String(data: data, encoding: .utf8)
            let regex = try! NSRegularExpression(pattern: "filename=\"(.*?)\"")
            let matches = regex.matches(in: string!, range: NSRange(location: 0, length: string!.count))
            if let match = matches.first {
                let fileName = (string! as NSString).substring(with: match.range(at: 1))
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Upload File", message: fileName, preferredStyle: .actionSheet)
                    alert.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { (action) in
                        self.showImagePicker()
                    }))
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        return nil
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        print(chosenImage)
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated:true, completion: nil)
    }
}
