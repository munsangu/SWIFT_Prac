import UIKit

class ViewController: UIViewController, SendDataDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController가 로드됨")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController가 나타날 것")
    }
    
    @IBOutlet weak var deligate: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewController가 나타남")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewController가 사라질 것")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ViewController가 사라짐")
    }
    
    @IBAction func codePushBTN(_ sender: UIButton) {
        guard let viewController = storyboard?.instantiateViewController(identifier: "CodePushViewController") as? CodePushViewController else { return }
        viewController.receive = "IRONMAN"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func codePresentBTN(_ sender: UIButton) {
        guard let viewController = storyboard?.instantiateViewController(identifier: "CodePresentViewController") as?  CodePresentViewController else { return }
        viewController.receive = "HURK"
        viewController.deligate = self
        present(viewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? SeguePushViewController {
            viewController.segueVal = "HAWKEYE"
        }
    }
    
    func sendData(name: String) {
        deligate.text = name
    }
}

