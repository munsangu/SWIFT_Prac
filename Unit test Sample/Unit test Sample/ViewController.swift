//
//  ViewController.swift
//  Unit test Sample
//
//  Created by 문상우 on 2023/06/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatpasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        if passwordTextField.text != repeatpasswordTextField.text {
            let alert = UIAlertController(title: "Error", message: "비밀번호가 다릅니다", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            DispatchQueue.main.async {
                alert.view.accessibilityIdentifier = "errorAlert"
                self.present(alert, animated: true)
            }
        }
    }
    


}

