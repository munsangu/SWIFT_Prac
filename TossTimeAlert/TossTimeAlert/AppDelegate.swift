//
//  AppDelegate.swift
//  TossTimeAlert
//
//  Created by 문상우 on 2023/06/12.
//

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
        
        // FCM Current Registration Token Verification
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error FCM Token: \(error.localizedDescription)")
            } else if let token = token {
                print(token)
            }
        }
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, error in
            print("Error, Request Notifications Authrization: \(error.debugDescription)")
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
        tossOpen()
        completionHandler([.list, .banner, .sound, .badge])
    }
    
    // Receive push notification(Background mode) & Click push notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        tossOpen()
        completionHandler()
    }
    
    private func tossOpen() {
        let toss = "supertoss://"
        let tossURL = NSURL(string: toss)
        
        if(UIApplication.shared.canOpenURL(tossURL! as URL)) {
            UIApplication.shared.open(tossURL! as URL)
        } else {
            let tossAppStore = "https://apps.apple.com/app/id839333328"
            UIApplication.shared.open(URL(string: tossAppStore)!)
        }
    }
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        guard let token = fcmToken else {
            print("Failed to receive FCM Token.")
            return
        }
        print(token)
        sendTokenToServer(token)
    }
    
    func sendTokenToServer(_ token: String) {
        let url = URL(string: "https://wkwebview.run.goorm.site/token.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "token=\(token)"
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if response.statusCode == 200 {
                print("Value of FCM Token sent successfully")
                // Handle the response from the server, if any
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Server response: \(responseString)")
                }
            } else {
                print("Error sending token: HTTP status code \(response.statusCode)")
            }
        }
        task.resume()
    }
    
    
}

