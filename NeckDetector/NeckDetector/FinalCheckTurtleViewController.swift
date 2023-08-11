import UIKit

class FinalCheckTurtleViewController: UIViewController {
    
    @IBOutlet weak var userNickNameLabel: UILabel!
    @IBOutlet weak var turtleLevelLabel: UILabel!
    @IBOutlet weak var recheckButton: UIButton!
    @IBOutlet weak var neckStretchButton: UIButton!
    @IBOutlet weak var resultPhotoImageView: UIImageView!
    
    let turtleNames: [String] = ["꾸북보스", "꾸북이", "예비 꾸북이", "꾸북이 사냥꾼"]
    let turtleImages: [String] = ["resultTurtle1", "resultTurtle2", "resultTurtle3", "resultTurtle4"]
    
    var turtleLabel = UserDefaults.standard.string(forKey: "turtleLabel") // 0.0 ~ 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNickNameLabel.text = UserDefaults.standard.string(forKey: "userNickname")
        
        switch turtleLabel {
        case "00% 꾸북이":
            turtleLevelLabel.text = "꾸북이 사냥꾼"
            resultPhotoImageView.image = UIImage(named: "resultTurtle4")
        case "30% 꾸북이":
            turtleLevelLabel.text = "예비 꾸북이"
            resultPhotoImageView.image = UIImage(named: "resultTurtle3")
        case "60% 꾸북이":
            turtleLevelLabel.text = "꾸북이"
            resultPhotoImageView.image = UIImage(named: "resultTurtle2")
        case "90% 꾸북이":
            turtleLevelLabel.text = "꾸북보스"
            resultPhotoImageView.image = UIImage(named: "resultTurtle1")
        default:
            break
        }
        
        recheckButton.layer.cornerRadius = 16
        neckStretchButton.layer.cornerRadius = 16
    }
    
    @IBAction func imageDownloadButtonTapped(_ sender: Any) {
        guard let imageToSave = resultPhotoImageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Error saving image: \(error.localizedDescription)")
            self.showToast("이미지 저장 실패", withDuration: 2.0, delay: 1.0)
        } else {
            self.showToast("이미지 저장 완료", withDuration: 2.0, delay: 1.0)
        }
    }
    
    @IBAction func recheckButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainViewController = storyboard.instantiateViewController(withIdentifier: "mainTabBarController") as? UITabBarController {
            mainViewController.modalPresentationStyle = .fullScreen
            self.present(mainViewController, animated: false)
        }
    }
    
  
    @IBAction func neckStretchButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainViewController = storyboard.instantiateViewController(withIdentifier: "mainTabBarController") as? UITabBarController {
            mainViewController.modalPresentationStyle = .fullScreen
            self.present(mainViewController, animated: false)
        }
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
