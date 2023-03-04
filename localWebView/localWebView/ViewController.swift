// Local에 있는 HTML 파일과 Communication
import UIKit
import WebKit
import TAKUUID

class ViewController: UIViewController {

    var myUUID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUUID()
        
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        let contentController = webView.configuration.userContentController
        contentController.add(self, name: "loadUUID")
        
        let js = """
                window.addEventListener('load', () => {
                let msg = "complete"
                if(window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.loadUUID) {
                   window.webkit.messageHandlers.loadUUID.postMessage({ "message": msg })
                }
            })
        """
        
        let script = WKUserScript(source: js, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        contentController.addUserScript(script)
        
        // local html을 불러오는 소스
//        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
//            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
//        }
        
        // remote html을 불러오는 소스
        if let url2 = URL(string: "https://ubiquitous-chebakia-cee94b.netlify.app/") {
            webView.load(URLRequest(url: url2))
        }
    }

    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private func initUUID() {
        TAKUUIDStorage.sharedInstance().migrate()
        myUUID = TAKUUIDStorage.sharedInstance().findOrCreate()!
    }

}

extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let dict = message.body as? [String: AnyObject] else { return }
        guard dict["message"] != nil else { return }
        let script = "document.getElementById('uuid').innerText = \"\(myUUID)\""
        webView.evaluateJavaScript(script) { (result, error) in
            if let result = result {
                print("UR UUID: \(result)")
            } else if let error = error {
                print("An error occurred: \(error)")
            }
        }
    }
}
