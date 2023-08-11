import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var userNicknameLabel: UILabel!
    @IBOutlet weak var alertImageView: UIImageView!
    @IBOutlet weak var myCharacterImage: UIImageView!
    @IBOutlet weak var searchNeckView: UIView!
        
    @IBOutlet weak var turtleCamera: UIView!
    @IBOutlet weak var turtleBook: UIView!
    @IBOutlet weak var turtleHunt: UIView!
    @IBOutlet weak var turtleCheck: UIView!
    
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
        
        let turtleCameraTap = UITapGestureRecognizer(target: self, action: #selector(didTapTurtleCameraTap))
        turtleCameraTap.numberOfTapsRequired = 1
        turtleCamera.isUserInteractionEnabled = true
        turtleCamera.addGestureRecognizer(turtleCameraTap)
        
        let turtleBookTap = UITapGestureRecognizer(target: self, action: #selector(didTapTurtleCameraTap))
        turtleBookTap.numberOfTapsRequired = 1
        turtleBook.isUserInteractionEnabled = true
        turtleBook.addGestureRecognizer(turtleBookTap)
        
        let turtleHuntTap = UITapGestureRecognizer(target: self, action: #selector(didTapAlertImageView))
        turtleHuntTap.numberOfTapsRequired = 1
        turtleHunt.isUserInteractionEnabled = true
        turtleHunt.addGestureRecognizer(turtleHuntTap)
        
        let turtleCheckTap = UITapGestureRecognizer(target: self, action: #selector(didTapAlertImageView))
        turtleCheckTap.numberOfTapsRequired = 1
        turtleCheck.isUserInteractionEnabled = true
        turtleCheck.addGestureRecognizer(turtleCheckTap)

    }
    
    @objc func didTapAlertImageView() {
        self.showToast("준비중입니다", withDuration: 2.0, delay: 1.0)
    }
    
    @objc func didTapSearchNeckViewTap() {
        if let searchNeckViewController = self.storyboard?.instantiateViewController(withIdentifier: "searchNeckViewController") {
            navigationController?.pushViewController(searchNeckViewController, animated: true)
        }
    }
    
    @objc func didTapTurtleCameraTap() {
        if let cameraViewController = self.storyboard?.instantiateViewController(withIdentifier: "cameraViewController") {
            cameraViewController.modalPresentationStyle = .fullScreen
            self.present(cameraViewController, animated: true)
        }
    }
    
    @objc func didTapdetectView() {
        self.showToast("준비중입니다", withDuration: 2.0, delay: 1.0)
    }
    
    @objc func didTapEncyclopediaView() {
        self.showToast("준비중입니다", withDuration: 2.0, delay: 1.0)
    }
    
    func showToast(_ message : String, withDuration: Double, delay: Double) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont.systemFont(ofSize: 14.0)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 16
        toastLabel.clipsToBounds = true
            
        self.view.addSubview(toastLabel)
            
        UIView.animate(withDuration: withDuration, delay: delay, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }

}
