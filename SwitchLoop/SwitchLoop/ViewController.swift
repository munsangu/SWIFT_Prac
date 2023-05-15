//
//  ViewController.swift
//  SwitchLoop
//
//  Created by 문상우 on 2023/05/15.
//

import UIKit

class ViewController: UIViewController {
    
    var timer: Timer?
    var timer2: Timer?
    var count: Int = 1
    var count2: Int = 1
    

    @IBOutlet weak var firstValue: UILabel!
    @IBOutlet weak var secondValue: UILabel!
    @IBOutlet weak var returnValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstValue.text = "1"
        secondValue.text = "1"
        returnValue.text = ""
    }
    
    
    @IBAction func firstBtnTapped(_ sender: UIButton) {
        _ = self.switchLoop("first")
    }
    
    @IBAction func secondBtnTapped(_ sender: UIButton) {
        _ = self.switchLoop("second")
    }
    
    @IBAction func returnBtnTapped(_ sender: UIButton) {
        returnValue.text = self.switchLoop("return")
    }
    
    @IBAction func stopBtnTapped(_ sender: UIButton) {
        _ = self.switchLoop("stop")
    }
    
    func switchLoop(_ value: String) -> String {
        
        switch value {
        case "first":
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(addNum), userInfo: nil, repeats: true)
            return "1"
            
        case "second":
            timer2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(addNum2), userInfo: nil, repeats: true)
            return "1"
            
        case "stop":
            timer?.invalidate()
            timer = nil
            firstValue.text = "1"
            
            timer2?.invalidate()
            timer2 = nil
            secondValue.text = "1"
            
            return "1"
            
        default:
            return "3"
        }
        
    }
    
    @objc func addNum() {
        count += 1
        firstValue.text = String(count)
    }
    
    @objc func addNum2() {
        count2 += 2
        secondValue.text = String(count2)
    }
    

}

