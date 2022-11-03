//
//  ViewController.swift
//  MyFirstiOS
//
//  Created by MSW on 2022/11/03.
//

// Apple이 만든 Framework를 사용하겠다는 의미
import UIKit

class ViewController: UIViewController {
    
    // IB: Interface Builder
    // 연결된 것을 끊을 때 코드만 삭제하면 에러 발생
    // 1. viewController 내 해당 요소 우클릭 후 연결된 것 삭제
    // 2. 어시스턴트 가장 왼쪽(삼각자 오른쪽)에서 연결된 것 중에서 필요없는 것 삭제
    
    // 변수 생성
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainBtn: UIButton!
    
    // 앱 화면에 들어오면 처음 실행되는 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainLabel.text = "Can u hear me???"
        mainLabel.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        mainLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }

        @IBAction func btnPressed(_ sender: UIButton) {
            
            // 색상 변경 -> #colorLiteral()
            // 이미지 선택 -> #iamgeLiteral()
            mainLabel.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            mainLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            mainLabel.text = "Who R U????"
            
            mainBtn.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
}

