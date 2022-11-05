//
//  ViewController.swift
//  myFourthiOS
//
//  Created by 문상우 on 2022/11/05.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    
    var comChoice = Int.random(in: 1...10)
    var myChoice = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.text = "아래 숫자들 중에서 선택"
        numLabel.text = ""
    }

    @IBAction func btnPressed(_ sender: UIButton) {
        guard let numString = sender.currentTitle else {
            return
            
        }
        numLabel.text = numString
        guard let num = Int(numString) else {return}
        myChoice = num
    }
    
    
    @IBAction func resetBTNPressed(_ sender: Any) {
        mainLabel.text = "아래 숫자들 중에서 선택"
        numLabel.text = ""
        comChoice = Int.random(in: 1...10)
    }
    
    @IBAction func selectBTNPressed(_ sender: UIButton) {
        if(comChoice > myChoice) {
            mainLabel.text = "👍"
        } else if(comChoice < myChoice) {
            mainLabel.text = "👎"
        } else {
            mainLabel.text = "👌"
        }
    }
}

// 2안
//class ViewController: UIViewController {
//
//    @IBOutlet weak var mainLabel: UILabel!
//    @IBOutlet weak var numLabel: UILabel!
//
//    var comChoice = Int.random(in: 1...10)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        mainLabel.text = "아래 숫자들 중에서 선택"
//        numLabel.text = ""
//    }
//
//    @IBAction func btnPressed(_ sender: UIButton) {
//        guard let numString = sender.currentTitle else {
//            return
//
//        }
//        numLabel.text = numString
//    }
//
//    @IBAction func selectBTNPressed(_ sender: UIButton) {
//        guard let myNumString = numLabel.text else {return}
//        guard let myNum = Int(myNumString) else {return}
//            if(comChoice > myNum) {
//                mainLabel.text = "👍"
//            } else if(comChoice < myNum) {
//                mainLabel.text = "👎"
//            } else {
//                mainLabel.text = "👌"
//            }
//    }
//
//    @IBAction func resetBTNPressed(_ sender: UIButton) {
//        mainLabel.text = "아래 숫자들 중에서 선택"
//        numLabel.text = ""
//        comChoice = Int.random(in: 1...10)
//    }
//
//}


