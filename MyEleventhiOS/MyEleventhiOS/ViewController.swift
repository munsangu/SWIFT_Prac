import UIKit

enum Operation {
    case Plus
    case Substract
    case Multiple
    case Divide
    case unknown
}

class ViewController: UIViewController {

    @IBOutlet weak var numOutputLabel: UILabel!
    @IBOutlet weak var divideBTN: UIButton!
    @IBOutlet weak var multipleBTN: UIButton!
    @IBOutlet weak var substractBTN: UIButton!
    @IBOutlet weak var plusBTN: UIButton!
    
    var displayNum = ""
    var firstOperator = ""
    var secondOperator = ""
    var result = ""
    var currentOperator: Operation = .unknown
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func numBTN(_ sender: UIButton) {
        guard let numVal = sender.title(for: .normal) else { return
        }
        if displayNum.count < 9 {
            displayNum += numVal
            numOutputLabel.text = displayNum
        }
    }
    
    @IBAction func clearBTN(_ sender: UIButton) {
        displayNum = ""
        firstOperator = ""
        secondOperator = ""
        result = ""
        currentOperator = .unknown
        numOutputLabel.text = "0"
    }
    
    @IBAction func dotBTN(_ sender: UIButton) {
        if displayNum.count < 8, !displayNum.contains(".") {
            displayNum += displayNum.isEmpty ? "0." : "."
            numOutputLabel.text = displayNum
        }
    }
    
    
    @IBAction func divideBTN(_ sender: UIButton) {
        self.operate(.Divide)
    }
    
    
    @IBAction func multipleBTN(_ sender: UIButton) {
        self.operate(.Multiple)
    }
    
    
    @IBAction func substractBTN(_ sender: UIButton) {
        self.operate(.Substract)
    }
    
    
    @IBAction func plusBTN(_ sender: UIButton) {
        self.operate(.Plus)
    }
    
    
    @IBAction func resultBTN(_ sender: UIButton) {
        self.operate(self.currentOperator)
    }
    
    func operate(_ operation: Operation) {
        if currentOperator != .unknown {
            if !displayNum.isEmpty {
                secondOperator = displayNum
                displayNum = ""
            
            guard let firstNum = Double(firstOperator) else { return }
            guard let secondNum = Double(secondOperator) else { return }
            
            switch currentOperator {
                case .Plus:
                    result = "\(firstNum + secondNum)"
                case .Substract:
                    result = "\(firstNum - secondNum)"
                case .Multiple:
                    result = "\(firstNum * secondNum)"
                case .Divide:
                    result = "\(firstNum / secondNum)"
                default:
                    break
            }
            
                if let res = Double(result), res.truncatingRemainder(dividingBy: 1) == 0 {
                    result = "\(Int(res))"
                }
            firstOperator = result
            numOutputLabel.text = result
            }
            currentOperator = operation
        } else {
            firstOperator = displayNum
            currentOperator = operation
            displayNum = ""
        }
    }
        
}

