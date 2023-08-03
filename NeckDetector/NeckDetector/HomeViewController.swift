import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var userNicknameLabel: UILabel!
    @IBOutlet weak var alertImageView: UIImageView!
    @IBOutlet weak var myCharacterImage: UIImageView!
    @IBOutlet weak var searchNeckView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNicknameLabel.text = UserDefaults.standard.string(forKey: "userNickname")
            
        searchNeckView.layer.cornerRadius = 20
        
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
        print("Let's search Neck!!")
    }
    
    @objc func didTapdetectView() {
        print("Open Detector!!!")
    }
    
    @objc func didTapEncyclopediaView() {
        print("Open Encyclopedia!!!")
    }

}
