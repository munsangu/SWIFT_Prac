import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var userInfoView: UIView!
    @IBOutlet weak var settingsIcon: UIImageView!
    
    @IBOutlet weak var careStackView: UIStackView!
    @IBOutlet weak var diaryStackVIew: UIStackView!
    @IBOutlet weak var searchStackView: UIStackView!
    @IBOutlet weak var shoppingStackView: UIStackView!
    @IBOutlet weak var friendStackView: UIStackView!
    @IBOutlet weak var badgeStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileView.layer.cornerRadius = profileView.bounds.height / 2
        userInfoView.layer.cornerRadius = 16
        
//        let turtleViewTap = UITapGestureRecognizer(target: self, action: #selector(openNewViewController))
//        turtleView.addGestureRecognizer(turtleViewTap)
    }
    
//    @objc func openNewViewController() {
//        let turtleViewController = TurtleViewController()
//        turtleViewController.modalPresentationStyle = .fullScreen
//        self.present(turtleViewController, animated: true)
//    }
    
}
