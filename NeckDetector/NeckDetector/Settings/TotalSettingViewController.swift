import UIKit

class TotalSettingViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var recordView: UIView!
    @IBOutlet weak var levelView: UILabel!
    
    @IBOutlet weak var historyStackView: UIStackView!
    @IBOutlet weak var diaryStackView: UIStackView!
    @IBOutlet weak var searchNeckStackView: UIView!
    @IBOutlet weak var shoppingStackView: UIStackView!
    
    @IBOutlet weak var meetStackView: UIStackView!
    @IBOutlet weak var badgeStackView: UIStackView!
    
//    let userName = UserDefaults.standard.string(forKey: "userNickName")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        guard let userName = userName else { return }
//        userNameLabel.text = "님"
        
        levelView.layer.cornerRadius = 16
        recordView.layer.cornerRadius = 16
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(didHistoryStackView))
        tap1.numberOfTapsRequired = 1
        historyStackView.isUserInteractionEnabled = true
        historyStackView.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(didDiaryStackView))
        tap2.numberOfTapsRequired = 1
        diaryStackView.isUserInteractionEnabled = true
        diaryStackView.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(didSearchNeckStackView))
        tap3.numberOfTapsRequired = 1
        searchNeckStackView.isUserInteractionEnabled = true
        searchNeckStackView.addGestureRecognizer(tap3)
        
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(didShoppingStackView))
        tap4.numberOfTapsRequired = 1
        shoppingStackView.isUserInteractionEnabled = true
        shoppingStackView.addGestureRecognizer(tap4)
        
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(didMeetStackView))
        tap5.numberOfTapsRequired = 1
        meetStackView.isUserInteractionEnabled = true
        meetStackView.addGestureRecognizer(tap5)
        
        let tap6 = UITapGestureRecognizer(target: self, action: #selector(didBadgeStackView))
        tap6.numberOfTapsRequired = 1
        badgeStackView.isUserInteractionEnabled = true
        badgeStackView.addGestureRecognizer(tap6)
        
    }
    
    @IBAction func retouchButtonTapped(_ sender: UIButton) {
        if let retouchingViewController = self.storyboard?.instantiateViewController(withIdentifier: "retouchingViewController") {
            navigationController?.pushViewController(retouchingViewController, animated: true)
        }
    }
    
    @objc func didHistoryStackView() {
        if let historyViewController = self.storyboard?.instantiateViewController(withIdentifier: "diaryViewController") {
            navigationController?.pushViewController(historyViewController, animated: true)
        }
    }
    
    @objc func didDiaryStackView() {
        if let diaryViewController = self.storyboard?.instantiateViewController(withIdentifier: "historyViewController") {
            navigationController?.pushViewController(diaryViewController, animated: true)
        }
    }
    
    @objc func didSearchNeckStackView() {
        if let searchNeckViewController = self.storyboard?.instantiateViewController(withIdentifier: "searchNeckViewController") {
            navigationController?.pushViewController(searchNeckViewController, animated: true)
        }
    }

    @objc func didShoppingStackView() {
        if let shoppingViewController = self.storyboard?.instantiateViewController(withIdentifier: "shoppingViewController") {
            navigationController?.pushViewController(shoppingViewController, animated: true)
        }
    }
    
    @objc func didMeetStackView() {
        self.showToast("준비중입니다", withDuration: 2.0, delay: 1.0)
    }
    
    @objc func didBadgeStackView() {
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
        toastLabel.clipsToBounds  =  true
            
        self.view.addSubview(toastLabel)
            
        UIView.animate(withDuration: withDuration, delay: delay, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
