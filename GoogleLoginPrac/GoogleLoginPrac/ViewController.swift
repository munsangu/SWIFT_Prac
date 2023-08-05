import UIKit
import GoogleSignIn

class ViewController: UIViewController {
    
    @IBOutlet weak var googleLoginView: UIView!
    
    let signInConfig = GIDConfiguration(clientID: "195688937535-u930jpp0r50r2ceg42b7rd0itbtq36eo.apps.googleusercontent.com")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = GIDSignInButton()
        button.colorScheme = .light
        button.style = .wide
        googleLoginView.addSubview(button)
        
        button.addTarget(self, action: #selector(googleBTN), for: .touchUpInside)
    }
    
    @objc func googleBTN() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
          guard error == nil else { return }
            guard let signInResult = signInResult else { return }
            let user = signInResult.user
            let emailAddress = user.profile?.email
            guard let email = emailAddress else { return }
            print("USER: \(user)")
            print("Email address: \(email)")
          // If sign in succeeded, display the app's main content View.
        }
    }
    
}

