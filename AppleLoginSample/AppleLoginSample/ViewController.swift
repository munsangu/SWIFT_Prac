//
//  ViewController.swift
//  AppleLoginSample
//
//  Created by 문상우 on 2023/06/26.
//

import AuthenticationServices
import SnapKit
import UIKit

class ViewController: UIViewController {
    
    let logoImageView = UIImageView()
    let welcomeLabel = UILabel()
    let signInButton = ASAuthorizationAppleIDButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.makeView()
        self.setViews()
    }
    
    private func makeView() {
        self.logoImageView.image = UIImage(systemName: "applelogo")
        self.logoImageView.tintColor = .systemGray
        self.logoImageView.contentMode = .scaleAspectFit
        
        self.welcomeLabel.numberOfLines = 0
        self.welcomeLabel.textAlignment = .center
        self.welcomeLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        self.welcomeLabel.text = "Welcome! Sign with Apple to enjoy our service"
        self.welcomeLabel.textColor = .label
        
        self.signInButton.layer.cornerRadius = 25
        self.signInButton.layer.borderWidth = 0.5
        self.signInButton.addTarget(self, action: #selector(tappedAppleLoginButton), for: .touchUpInside)
    }
    
    @objc func tappedAppleLoginButton() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func setViews() {
        [logoImageView, welcomeLabel, signInButton].forEach({ view.addSubview($0) })
        
        self.logoImageView.snp.makeConstraints({
            $0.width.equalTo(50)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.80)
        })
        
        self.welcomeLabel.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(self.logoImageView.snp.bottom).offset(20)
        })
        
        self.signInButton.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.top.equalTo(self.welcomeLabel.snp.bottom).offset(60)
            $0.height.equalTo(50)
        })
    }

}

extension ViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            if let authorizationCode = appleIDCredential.authorizationCode,
               let identityToken = appleIDCredential.identityToken,
               let authCodeString = String(data: authorizationCode, encoding: .utf8),
               let identityTokenString = String(data: identityToken, encoding: .utf8) {
                print("authorizationCode: \(authorizationCode)")
                print("identityToken: \(identityToken)")
                print("authCodeString: \(authCodeString)")
                print("idetityTokenString: \(identityTokenString)")
            }
            
            print("userIdentifier: \(userIdentifier)")
            print("fullName: \(fullName!)")
            print("email: \(email!)")
            
            break
        case let passwordCredential as ASPasswordCredential:
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            print("username: \(username)")
            print("password: \(password)")
            
            break
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
}
