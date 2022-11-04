//
//  ViewController.swift
//  MySecondiOS
//
//  Created by 문상우 on 2022/11/04.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var firstImgView: UIImageView!
    @IBOutlet weak var secondImgView: UIImageView!
    
    var diceArray: [UIImage] = [#imageLiteral(resourceName: "black1"), #imageLiteral(resourceName: "black2"), #imageLiteral(resourceName: "black3"), #imageLiteral(resourceName: "black4"), #imageLiteral(resourceName: "black5"), #imageLiteral(resourceName: "black6")]
    override func viewDidLoad() {
        super.viewDidLoad()
        firstImgView.image = diceArray.randomElement()
        secondImgView.image = diceArray.randomElement()
    }

    @IBAction func rollDiceBTN(_ sender: UIButton) {
        // 첫 번째 이미지(왼쪽)뷰의 이미지를 랜덤으로 변경
        firstImgView.image = diceArray.randomElement()
        
        // 두 번째 이미지(오른쪽)뷰의 이미지를 랜덤으로 변경
        secondImgView.image = diceArray.randomElement()
        
    }
}

