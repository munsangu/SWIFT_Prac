import UIKit
import AVFoundation
import WebKit
import SafeAreaBrush
import UserNotifications
import FirebaseMessaging

class ViewController: UIViewController {
    
    @IBOutlet weak var webViewGroup: UIView!
    
    let myToken = UserDefaults.standard.string(forKey: "fcmToken")
    var fcmToken: String?
    
    var player: AVAudioPlayer?
    
    var myWebView: WKWebView!
    let configuration = WKWebViewConfiguration()
    let contentController = WKUserContentController()
    var websiteDateStore = WKWebsiteDataStore.default()
    var isScrolling = false
    var nowURL = "https://wkwebview.run.goorm.site/"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.fillSafeArea(position: .top, color: UIColor(red: 34 / 255, green: 34 / 255, blue: 34 / 255, alpha: 1.0))
        DispatchQueue.main.async {
            Messaging.messaging().token { token, error in
                if let err = error {
                    print("ERROR Fetching FCM Token: \(err.localizedDescription)")
                } else if let fcmToken = token {
                    print("My FCM Token is \(fcmToken) in ViewController")
                }
            }
            self.webViewSetting()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        willBecomeActive()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        willBecomeActiveDelete()
        
    }
    
    func willBecomeActive() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidBecome), name: UIApplication.didBecomeActiveNotification, object: nil)
        
    }
    
    func willBecomeActiveDelete() {
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
    @objc func applicationDidBecome() {
        
        guard let url = URL(string: UserDefaults.standard.string(forKey: "PUSH_URL") ?? "\(nowURL)") else {
            fatalError("Invaild URL")
        }
        
        websiteDateStore.httpCookieStore.getAllCookies { cookies in
            do {
                let archivedCookies = try NSKeyedArchiver.archivedData(withRootObject: cookies, requiringSecureCoding: true)
                UserDefaults.standard.set(archivedCookies, forKey: "savedCookies")
            } catch {
                print("ERROR archiving cookies: \(error.localizedDescription)")
            }
        }
        
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 0)
        myWebView.load(request)
        
        UserDefaults.standard.set("\(nowURL)", forKey: "PUSH_URL")
        UserDefaults.standard.synchronize()
        
    }
    
    func webViewSetting() {
        
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        contentController.add(self, name: "safeAreaColor")
        contentController.add(self, name: "safeAreaColor2")
        contentController.add(self, name: "vibration")
        
        configuration.preferences = preferences
        configuration.userContentController = contentController
        configuration.websiteDataStore = websiteDateStore
        
        myWebView = WKWebView(frame: self.view.bounds, configuration: configuration)
        myWebView.translatesAutoresizingMaskIntoConstraints = false
        myWebView.uiDelegate = self
        myWebView.navigationDelegate = self
        myWebView.scrollView.delegate = self
        myWebView.scrollView.contentInsetAdjustmentBehavior = .never
        if #available(iOS 16.4, *) {
            myWebView.isInspectable = true
        }
        myWebView.scrollView.alwaysBounceVertical = false
        myWebView.scrollView.bounces = false
        webViewGroup.addSubview(myWebView)
        
        // Auto layout
        myWebView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.init(item: myWebView, attribute: .leading, relatedBy: .equal, toItem: webViewGroup, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: myWebView, attribute: .trailing, relatedBy: .equal, toItem: webViewGroup, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: myWebView, attribute: .top, relatedBy: .equal, toItem: webViewGroup, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: myWebView, attribute: .bottom, relatedBy: .equal, toItem: webViewGroup, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        webViewGroup.layoutIfNeeded()
        
    }
        

}


extension ViewController: WKUIDelegate {
    
    // Web page Alert
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo) async {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: .cancel)
        
        let messageAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 15)]
        let messageString = NSAttributedString(string: message, attributes: messageAttributes)
        
        alert.setValue(messageString, forKey: "attributedMessage")
        alert.addAction(okayAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
        
    }
    
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
        guard !isScrolling else { return }
        isScrolling = true
        
        if scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset = CGPoint.zero
        }
        
        if scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height {
            let offset = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentSize.height - scrollView.bounds.size.height)
            scrollView.setContentOffset(offset, animated: false)
        }
        
        isScrolling = false
        
    }

}

extension ViewController: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        switch message.name {
        case "safeAreaColor":
            fillSafeArea(position: .top, color: UIColor(red: 0 / 255, green: 0 / 255, blue: 255 / 255, alpha: 1.0))
            break
        case "safeAreaColor2":
            fillSafeArea(position: .top, color: UIColor(red: 255 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1.0))
            break
        case "vibration":
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        default:
            print(message.name)
        }
        
    }
    
}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if navigationAction.navigationType == .linkActivated {
            if let url = navigationAction.request.url, url.scheme == "tel" {
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        guard let currentURL = webView.url?.absoluteString else { return }
        nowURL = currentURL
        print("Now URL is \(nowURL)")
        
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                self.websiteDateStore.httpCookieStore.setCookie(cookie)
                break
            }
        }
        
        let script = """

        document.querySelector("meta[name=viewport]").setAttribute("content", "width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0")
         let tags = document.getElementsByTagName('*');
         for (var i = 0; i < tags.length; i++) {
             tags[i].style.webkitUserSelect = "none";
             tags[i].style.webkitTouchCallout = "none";
             tags[i].style.webkitUserDrag = "none";
             if (tags[i].tagName == "A") {
                 tags[i].setAttribute("draggable", false);
             }
         }

        """
        webView.evaluateJavaScript(script)
        
    }
    
}

