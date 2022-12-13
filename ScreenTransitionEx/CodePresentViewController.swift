import UIKit

protocol SendDataDelegate: AnyObject {
    func sendData(name: String)
}

class CodePresentViewController: UIViewController {

    @IBOutlet weak var receiveLabel: UILabel!
    var receive: String?
    weak var deligate: SendDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let receive = receive {
            receiveLabel.text = receive
        }
    }
    
    @IBAction func backBTN(_ sender: UIButton) {
        deligate?.sendData(name: "Thor")
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
