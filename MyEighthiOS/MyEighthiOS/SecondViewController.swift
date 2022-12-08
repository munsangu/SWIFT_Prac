import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var bmiNumLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var returnBTN: UIButton!
    
    // 전화면에서 전달받은 데이터들
    var bmiNum: Double?
    var adviceString: String?
    var bmiColor: UIColor?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let bmi = bmiNum else { return }
        bmiNumLabel.text = String(bmi)

        bmiNumLabel.backgroundColor = bmiColor
        adviceLabel.text = adviceString
        
        makeUI()
    }
    
    func makeUI() {
        
        bmiNumLabel.clipsToBounds = true
        bmiNumLabel.layer.cornerRadius = 8
//        bmiNumLabel.backgroundColor = .gray
        
        returnBTN.clipsToBounds = true
        returnBTN.layer.cornerRadius = 5
    }
    
    @IBAction func returnBTN(_ sender: UIButton) {
       dismiss(animated: true, completion: nil)
    }
}
