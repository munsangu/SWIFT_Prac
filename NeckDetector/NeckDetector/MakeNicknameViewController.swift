import UIKit

class MakeNicknameViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var nicknameValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nicknameValue.borderStyle = .none
        nicknameValue.backgroundColor = .clear
        startButton.layer.cornerRadius = 16
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        guard let userNickname = nicknameValue.text else {
            return
        }
        UserDefaults.standard.set(userNickname, forKey: "userNickname")
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "mainTabBarController") {
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: false)
        }
    }
    
}
