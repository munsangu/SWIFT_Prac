//
//  AppDelegate.swift
//  AppleLoginSample
//
//  Created by 문상우 on 2023/06/26.
//

import UIKit
import AuthenticationServices

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                break
            case .revoked, .notFound:
                DispatchQueue.main.async {
                    self.window?.rootViewController?.showLoginViewController()
                }
            default:
                break
            }
        }
        return true
    }
    
}
