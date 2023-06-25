//
//  LoginValidator.swift
//  Unit test Sample
//
//  Created by 문상우 on 2023/06/23.
//

import Foundation

class LoginValidator {
    
    func isVaildEmail(email: String) -> Bool {
        return email.contains("@")
    }
    
    func isValid(password: String) -> Bool {
        return password.count < 5
    }
    
}
