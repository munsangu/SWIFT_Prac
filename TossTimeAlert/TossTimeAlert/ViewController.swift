//
//  ViewController.swift
//  TossTimeAlert
//
//  Created by 문상우 on 2023/06/12.
//

import UIKit
import WebKit
import SafeAreaBrush

class ViewController: UIViewController {
    
    @IBOutlet weak var myWebView: WKWebView!
    var fcmToken: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillSafeArea(position: .top, color: UIColor(red: 54 / 255, green: 174 / 255, blue: 228 / 255, alpha: 1.0))
        self.webViewSetting("https://wkwebview.run.goorm.site/index2.php")
    }
    
    func webViewSetting(_ url: String) {
        if #available(iOS 16.4, *) {
            myWebView.isInspectable = true
        }
        guard let myUrl = URL(string: url) else { return }
        let request = URLRequest(url: myUrl)
        myWebView.load(request)
    }

}

