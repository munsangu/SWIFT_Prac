import UIKit
import UserNotifications
import FirebaseCore
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        return true
        
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        // Register fro push notification
        let authOptions: UNAuthorizationOptions = [.alert, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
            if error != nil {
                print("ERROR: \(error.debugDescription)")
            }
            if !granted {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                    
                    let titleAttributes: [NSAttributedString.Key : Any] = [
                        .font: UIFont.systemFont(ofSize: 18, weight: .bold),
                        .foregroundColor: UIColor(cgColor: CGColor(red: 255 / 255, green: 0, blue: 0, alpha: 1.0))
                    ]
                    let titleString = NSAttributedString(string: "Warning", attributes: titleAttributes)
                    alert.setValue(titleString, forKey: "attributedTitle")
                    
                    let okayAction = UIAlertAction(title: "Setting", style: .default) { _ in
                        guard let settingURL = URL(string: UIApplication.openSettingsURLString) else { return }
                        UIApplication.shared.open(settingURL)
                    }
                    
                    let noAction = UIAlertAction(title: "Cancel", style: .default) { action in return }
                    alert.addAction(okayAction)
                    alert.addAction(noAction)
                    
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let sceneDelegate = windowScene.delegate as? SceneDelegate,
                       let rootViewController = sceneDelegate.window?.rootViewController {
                        rootViewController.present(alert, animated: true)
                    }
                    
                }
            }
        }
        application.registerForRemoteNotifications()
        return true
        
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        Messaging.messaging().apnsToken = deviceToken
        
    }
    
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // Receive push notification(Foreground mode)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        guard let aps = userInfo["aps"] as? [String: Any],
              let alert = aps["alert"] as? [String: Any],
              let body = alert["body"] as? String,
              let viewController = UIApplication.shared.windows.first?.rootViewController as? ViewController else { return }
        
        if body.contains("okay") {
            viewController.myWebView.reload()
        }
        
        if let badgeValue = userInfo["badge"] as? Int {
            if badgeValue > 0 {
                UIApplication.shared.applicationIconBadgeNumber = 0
            }
        }
        
        completionHandler([.list, .banner, .sound, .badge])
        
    }
    
    // Receive push notification(Background mode) & Click push notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        
        
        UserDefaults.standard.set(userInfo["gcm.notification.url"] ?? "https://wkwebview.run.goorm.site/", forKey: "PUSH_URL")
        UserDefaults.standard.synchronize()
        
        if UIApplication.shared.applicationState == .active {
            if let viewController = UIApplication.shared.windows.first?.rootViewController as? ViewController {
                viewController.applicationDidBecome()
            }
        }
        
        completionHandler()
        
    }
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        guard let token = fcmToken else {
            print("Failed to receive FCM Token.")
            return
        }
        UserDefaults.standard.set(token, forKey: "fcmToken")
        //        print("My FCM Token is \(token) in AppDelegate")
        
        DispatchQueue.main.async {
            if let viewController = UIApplication.shared.windows.first?.rootViewController as? ViewController {
                viewController.fcmToken = UserDefaults.standard.string(forKey: "fcmToken")
                print("FCM Token is ready: \(viewController.fcmToken!)")
            }
        }
        
    }
    
    
}
