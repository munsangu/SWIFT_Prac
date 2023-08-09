import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var userNicknameLabel: UILabel!
    @IBOutlet weak var alertImageView: UIImageView!
    @IBOutlet weak var myCharacterImage: UIImageView!
    @IBOutlet weak var searchNeckView: UIView!
    
    @IBOutlet weak var turtleCamera: UIStackView!
    @IBOutlet weak var turtleHunt: UIStackView!
    @IBOutlet weak var turtleBook: UIStackView!
    @IBOutlet weak var turtleCheck: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNicknameLabel.text = UserDefaults.standard.string(forKey: "userNickname")
            
        searchNeckView.layer.cornerRadius = 20
        turtleCamera.layer.cornerRadius = 16
        turtleHunt.layer.cornerRadius = 16
        turtleBook.layer.cornerRadius = 16
        turtleCheck.layer.cornerRadius = 16
        
        let alertImageViewTap = UITapGestureRecognizer(target: self, action: #selector(didTapAlertImageView))
        alertImageViewTap.numberOfTapsRequired = 1
        alertImageView.isUserInteractionEnabled = true
        alertImageView.addGestureRecognizer(alertImageViewTap)
        
        let searchNeckViewTap = UITapGestureRecognizer(target: self, action: #selector(didTapSearchNeckViewTap))
        searchNeckViewTap.numberOfTapsRequired = 1
        searchNeckView.isUserInteractionEnabled = true
        searchNeckView.addGestureRecognizer(searchNeckViewTap)
        
        

    }
    
    @objc func didTapAlertImageView() {
        print("New Alert!!!")
    }
    
    @objc func didTapSearchNeckViewTap() {
        if let searchNeckViewController = self.storyboard?.instantiateViewController(withIdentifier: "searchNeckViewController") {
            navigationController?.pushViewController(searchNeckViewController, animated: true)
        }
    }
    
    @objc func didTapdetectView() {
        print("Open Detector!!!")
    }
    
    @objc func didTapEncyclopediaView() {
        print("Open Encyclopedia!!!")
    }

}
