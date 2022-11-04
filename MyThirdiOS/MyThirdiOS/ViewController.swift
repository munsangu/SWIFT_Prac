//
//  ViewController.swift
//  MyThirdiOS
//
//  Created by msw on 2022/11/04.
//

import UIKit

class ViewController: UIViewController {
    
    // 최상단 레이블
    @IBOutlet weak var mainLabel: UILabel!
    
    // 가위 바위 보 이미지
    @IBOutlet weak var comImageView: UIImageView!
    @IBOutlet weak var myImageView: UIImageView!
    
    // 가위 바위 보 글자
    @IBOutlet weak var comChoiceLabel: UILabel!
    @IBOutlet weak var myChoiceLabel: UILabel!
    
    var comChoice: Rps = Rps(rawValue: Int.random(in: 0...2))!
    var myChoice: Rps = Rps.rock
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comImageView.image = #imageLiteral(resourceName: "ready")
        myImageView.image = UIImage(named: "ready.png")
        
        comChoiceLabel.text = "준비"
        myChoiceLabel.text = "준비"

    }
    
    
    @IBAction func rpsBTNTapped(_ sender: UIButton) {
        
//        guard let title = sender.currentTitle else {
//            return
//        }
        let title = sender.currentTitle!
        
        switch title {
        case "가위":
            myChoice = Rps.scissors
        case "바위":
            myChoice = Rps.rock
        case "보":
            myChoice = Rps.paper
        default:
            break
        }
        
    }
    
    @IBAction func selectBTNTapped(_ sender: UIButton) {
        
        switch comChoice {
        case Rps.scissors:
            comImageView.image = #imageLiteral(resourceName: "scissors")
            comChoiceLabel.text = "가위"
        case Rps.rock:
            comImageView.image = #imageLiteral(resourceName: "rock")
            comChoiceLabel.text = "바위"
        case Rps.paper:
            comImageView.image = #imageLiteral(resourceName: "paper")
            comChoiceLabel.text = "보"
        }
        
        switch myChoice {
        case Rps.scissors:
            myImageView.image = #imageLiteral(resourceName: "scissors")
            myChoiceLabel.text = "가위"
        case Rps.rock:
            myImageView.image = #imageLiteral(resourceName: "rock")
            myChoiceLabel.text = "바위"
        case Rps.paper:
            myImageView.image = #imageLiteral(resourceName: "paper")
            myChoiceLabel.text = "보"
        }
        
        if (comChoice == myChoice) {
            mainLabel.text = "비겼다"
        } else if (comChoice == .rock && myChoice == .paper || comChoice == .paper && myChoice == .scissors || comChoice == .scissors && myChoice == .rock) {
            mainLabel.text = "이겼다"
        }  else {
              mainLabel.text = "졌다"
        }
    }
    
    @IBAction func resetBTNTapped(_ sender: UIButton) {
        comImageView.image = #imageLiteral(resourceName: "ready")
        comChoiceLabel.text = "준비"
        
        myImageView.image = #imageLiteral(resourceName: "ready")
        myChoiceLabel.text = "준비"
        
        mainLabel.text = "가위 바위 보"
        
        comChoice = Rps(rawValue: Int.random(in: 0...2))!
    }
}
