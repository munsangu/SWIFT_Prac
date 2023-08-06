import UIKit

class FinalCheckTurtleViewController: UIViewController {
    
    @IBOutlet weak var userNickNameLabel: UILabel!
    @IBOutlet weak var turtleLevelLabel: UILabel!
    @IBOutlet weak var recheckButton: UIButton!
    @IBOutlet weak var neckStretchButton: UIButton!
    @IBOutlet weak var resultPhotoImageView: UIImageView!
    
    var resultOfPercentage = UserDefaults.standard.float(forKey: "turtlePercentage") // 0.0 ~ 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNickNameLabel.text = UserDefaults.standard.string(forKey: "userNickname")
        turtleLevelLabel.text =  UserDefaults.standard.string(forKey: "turtleLabel")
        recheckButton.layer.cornerRadius = 16
        neckStretchButton.layer.cornerRadius = 16
    }
    
    @IBAction func imageDownloadButtonTapped(_ sender: Any) {
        print("Download image!!")
    }
    
    @IBAction func recheckButtonTapped(_ sender: UIButton) {
//        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "cameraViewController") {
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: false)
//        }
    }
    
    
    @IBAction func neckStretchButtonTapped(_ sender: UIButton) {
        
    }
    
    
}
