import UIKit

class CodePushViewController: UIViewController {

    @IBOutlet weak var receiveLabel: UILabel!
    var receive: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let receive = receive {
            receiveLabel.text = receive
        }
    }
    
    @IBAction func backBTN(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
