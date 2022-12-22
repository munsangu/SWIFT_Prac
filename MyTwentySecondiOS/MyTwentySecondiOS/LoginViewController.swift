import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailLogin: UIButton!
    @IBOutlet weak var googleLogin: GIDSignInButton!
    @IBOutlet weak var appleLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
    
    func makeUI() {
        [emailLogin, googleLogin, appleLogin].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.backgroundColor = UIColor.gray.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = true
        GIDSignIn.sharedInstance().presentingViewController = self
    }
    
    @IBAction func emailBTN(_ sender: UIButton) {
        
    }
    
    @IBAction func googleBTN(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func appleBTN(_ sender: UIButton) {
        
    }
    
}
