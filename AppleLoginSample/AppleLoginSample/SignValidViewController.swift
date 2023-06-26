//
//  SignValidViewController.swift
//  AppleLoginSample
//
//  Created by 문상우 on 2023/06/26.
//

import UIKit
import SnapKit

class SignValidViewControll: UIViewController {
    
    let welcomeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.makeViews()
        self.setViews()
    }
    
    private func makeViews() {
        self.welcomeLabel.numberOfLines = 0
        self.welcomeLabel.textAlignment = .center
        self.welcomeLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        self.welcomeLabel.text = "Welcome! U r my user"
        self.welcomeLabel.textColor = .label
    }
    
    private func setViews() {
        [welcomeLabel].forEach({ view.addSubview($0) })
        
        self.welcomeLabel.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(self.view.snp.bottom).offset(20)
        })

    }
    
}
