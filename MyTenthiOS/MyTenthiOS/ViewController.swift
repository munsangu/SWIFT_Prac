import UIKit

class ViewController: UIViewController, displaySettingDelegate {

    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentLabel.textColor = UIColor.orange
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingViewController = segue.destination as? SettingViewController {
            settingViewController.delegate = self
            settingViewController.displayText = contentLabel.text
            settingViewController.textColor = contentLabel.textColor
            settingViewController.backgroundColor = view.backgroundColor ?? .black
        }
    }

    func changeSetting(text: String?, textColor: UIColor, backgroundColor: UIColor) {
        if let text = text {
            contentLabel.text = text
        }
        contentLabel.textColor = textColor
        view.backgroundColor = backgroundColor
    }

}

