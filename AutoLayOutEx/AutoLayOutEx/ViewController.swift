import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func changeColorBTN(_ sender: UIButton) {
        colorView.backgroundColor = UIColor.blue
        print("색상 변경 버튼이 클릭됨")
    }
    
}

