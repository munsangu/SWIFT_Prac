import UIKit
import UserNotifications
import FirebaseMessaging

class ViewController: UIViewController {
    
    var fcmToken: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            Messaging.messaging().token { token, error in
                if let err = error {
                    print("ERROR Fetching FCM Token: \(err.localizedDescription)")
                } else if let fcmToken = token {
                    print("My FCM Token is \(fcmToken) in ViewController")
                    self.fcmToken = fcmToken
                }
            }
        }
    }

    @IBAction func sendNotificationButtonPressed(_ sender: Any) {
        guard let myToken = fcmToken else { return }
        
        let message = [
            "notification": [
                "title": "Hello?",
                "body": "Can you hear me now??",
                "sound": "siren.mp3"
            ],
            "to": myToken
        ] as [String : Any]
        
        // Convert the message to JSON data
        let jsonData = try? JSONSerialization.data(withJSONObject: message, options: [])
        
        // Create the URL request
        guard let url = URL(string: "https://fcm.googleapis.com/fcm/send") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=myServiceKey", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        // Send the request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let data = data {
                let responseString = String(data: data, encoding: .utf8)
                print("Response: \(responseString ?? "")")
            }
        }
        task.resume()
    }
    
}

