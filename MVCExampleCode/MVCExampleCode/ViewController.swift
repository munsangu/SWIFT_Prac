import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var message: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        message.isHidden = true
    }
    
    @IBAction func didPressLogin(_ sender: UIButton) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        user = User(email: email, password: password)
        if user.email == "test@test.com" && user.password == "1234" {
            message.text = "Success Login!"
            message.isHidden = false
        } else {
            message.text = "Who R U?"
            message.isHidden = false
        }
    }
    
}
