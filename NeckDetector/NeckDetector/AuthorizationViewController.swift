import UIKit
import AVFoundation
import UserNotifications

class AuthorizationViewController: UIViewController {

    @IBOutlet weak var okButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        okButton.layer.cornerRadius = 16
    }
    
    @IBAction func okButtonTapped(_ sender: Any) {
        AVCaptureDevice.requestAccess(for: .video) { _ in
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in
                DispatchQueue.main.async {
                    if let makeNicknameViewController = self.storyboard?.instantiateViewController(withIdentifier: "makeNicknameViewController") {
                        makeNicknameViewController.modalPresentationStyle = .fullScreen
                        self.present(makeNicknameViewController, animated: false)
                    }
                }
            }
        }
    }
    
}
