//
//  ViewController.swift
//  TossTimeAlert
//
//  Created by 문상우 on 2023/06/12.
//

import UIKit
import WebKit
import UserNotifications
import FirebaseMessaging

class ViewController: UIViewController {
    
    @IBOutlet weak var myWebView: WKWebView!
    var myToken: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadMyTokenAndWebView()
    }
    
    func loadMyTokenAndWebView() {
        if let token = UserDefaults.standard.string(forKey: "fcmToken") {
            myToken = token
            loadWebView()
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(tokenDidUpdate), name: UserDefaults.didChangeNotification, object: nil)
        }
    }
    
    @objc func tokenDidUpdate() {
        if let token = UserDefaults.standard.string(forKey: "fcmToken") {
            myToken = token
            NotificationCenter.default.removeObserver(self, name: UserDefaults.didChangeNotification, object: nil)
            loadWebView()
        }
    }
    
    func loadWebView() {
        guard let token = myToken else { return }
        print("Token is \(token)")
        let url = "https://wkwebview.run.goorm.site/name.php?fcmToken=\(token)"
        webViewSetting(url)
    }
    
    
    func webViewSetting(_ url: String) {
        myWebView.uiDelegate = self
        if #available(iOS 16.4, *) {
            myWebView.isInspectable = true
        }
        guard let myUrl = URL(string: url) else { return }
        let request = URLRequest(url: myUrl)
        myWebView.load(request)
    }
    
}

extension ViewController: WKUIDelegate {
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo) async {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "확인", style: .cancel)
        let messageAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 15)]
        let messageString = NSAttributedString(string: message, attributes: messageAttributes)
        alert.setValue(messageString, forKey: "attributedMessage")
        alert.addAction(okayAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
}
