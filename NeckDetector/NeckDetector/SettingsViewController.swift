import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsIcon: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
//        userInfoView.layer.cornerRadius = 16
        
//        let turtleViewTap = UITapGestureRecognizer(target: self, action: #selector(openNewViewController))
//        turtleView.addGestureRecognizer(turtleViewTap)
    }
    
//    @objc func openNewViewController() {
//        let turtleViewController = TurtleViewController()
//        turtleViewController.modalPresentationStyle = .fullScreen
//        self.present(turtleViewController, animated: true)
//    }
    
}
