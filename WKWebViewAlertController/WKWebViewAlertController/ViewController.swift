import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
   
    var webView: WKWebView!
    
    override func loadView() {
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
               
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
        
        if let url = URL(string: "URL") {
            webView.load(URLRequest(url: url))
        }
        
    }
            
}

extension ViewController: WKUIDelegate {
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        if message.contains("tel") {
            let alertController = UIAlertController(title: "Emergency", message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Okay", style: .cancel) {
                _ in completionHandler()
            }
            alertController.addAction(cancelAction)
            DispatchQueue.main.async {
                self.present(alertController, animated: true)
            }
        } else {
            print("message: \(message)")
        }
    }
    
}
