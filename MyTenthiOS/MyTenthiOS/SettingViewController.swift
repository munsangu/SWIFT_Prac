import UIKit

protocol displaySettingDelegate: AnyObject {
    func changeSetting(text: String?, textColor: UIColor, backgroundColor: UIColor)
}

class SettingViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var blueBTN: UIButton!
    @IBOutlet weak var purpleBTN: UIButton!
    @IBOutlet weak var blackBTN: UIButton!
    @IBOutlet weak var greenBTN: UIButton!
    @IBOutlet weak var yellowBTN: UIButton!
    @IBOutlet weak var orangeBTN: UIButton!
    
    weak var delegate: displaySettingDelegate?
    
    var displayText: String?
    var textColor: UIColor = .orange
    var backgroundColor: UIColor = .black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
    
    private func makeUI() {
        if let displayText = self.displayText {
            textField.text = displayText
        }
        changeTextClr(color: textColor)
        changeBgClr(color: backgroundColor)
    }
    
    
    @IBAction func changeTextColor(_ sender: UIButton) {
        if sender == orangeBTN {
            changeTextClr(color: .orange)
            textColor = .orange
        } else if sender == yellowBTN {
            changeTextClr(color: .yellow)
            textColor = .yellow
        } else {
            changeTextClr(color: .green)
            textColor = .green
        }
    }

    @IBAction func changeBGColor(_ sender: UIButton) {
        if sender == blackBTN {
            changeBgClr(color: .black)
            backgroundColor = .black
        } else if sender == purpleBTN {
            changeBgClr(color: .purple)
            backgroundColor = .purple
        } else {
            changeBgClr(color: .blue)
            backgroundColor = .blue
        }
    }
    
    @IBAction func saveBTN(_ sender: UIButton) {
        delegate?.changeSetting(text: textField.text, textColor: textColor, backgroundColor: backgroundColor)
        navigationController?.popViewController(animated: true)
    }
    
    private func changeTextClr(color: UIColor) {
        orangeBTN.alpha = color == UIColor.orange ? 1 : 0.2
        yellowBTN.alpha = color == UIColor.yellow ? 1 : 0.2
        greenBTN.alpha = color == UIColor.green ? 1 : 0.2
    }
    
    private func changeBgClr(color: UIColor) {
        blackBTN.alpha = color == UIColor.black ? 1 : 0.2
        purpleBTN.alpha = color == UIColor.purple ? 1 : 0.2
        blueBTN.alpha = color == UIColor.blue ? 1 : 0.2
    }
}
