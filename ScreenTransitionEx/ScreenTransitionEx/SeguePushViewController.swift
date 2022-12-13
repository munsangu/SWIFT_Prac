import UIKit

class SeguePushViewController: UIViewController {

    @IBOutlet weak var segue: UILabel!
    var segueVal: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let seguez = segueVal {
            segue.text = seguez
        }
    }
    
    @IBAction func backBTN(_ sender: UIButton) {
        // 이전화면으로 이동
        navigationController?.popViewController(animated: true)
        
        // 루트화면으로 이동
        // navigationController?.popToRootViewController(animated: true)
    }
    
}
