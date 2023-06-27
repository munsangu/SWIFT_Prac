//
//  ResultViewController.swift
//  AppleLoginSample
//
//  Created by 문상우 on 2023/06/27.
//

import UIKit
import AuthenticationServices

class ResultViewController: UIViewController {
    
    @IBOutlet weak var userIdentifierLabel: UILabel!
    @IBOutlet weak var givenNameLabel: UILabel!
    @IBOutlet weak var familyNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var signOutButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        userIdentifierLabel.text = KeychainItem.currentUserIdentifier
        
    }
    
    @IBAction func signOutButtonPressed() {
        
        KeychainItem.deleteUserIdentifierFromKeychain()
        
        userIdentifierLabel.text = ""
        givenNameLabel.text = ""
        familyNameLabel.text = ""
        emailLabel.text = ""
        
        DispatchQueue.main.async {
            self.showLoginViewController()
        }
        
    }
    
}
