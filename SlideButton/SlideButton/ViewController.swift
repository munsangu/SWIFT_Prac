import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var cancelTxt: UILabel!
    @IBOutlet weak var cancelImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(touched(_:)))
        cancelImg.addGestureRecognizer(gestureRecognizer)
        cancelImg.isUserInteractionEnabled = true
        
    }
    
    @objc private func touched(_ gestureRecognizer: UIGestureRecognizer) {
        if let touchedView = gestureRecognizer.view {
            if gestureRecognizer.state == .changed {
                let locationInView = gestureRecognizer.location(in: touchedView)
                
                var newPos = touchedView.frame.origin.x + locationInView.x
                
                if newPos < 10 {
                    newPos = 10
                } else if newPos > 170 {
                    newPos = 170
                }
                
                touchedView.frame.origin.x = newPos
                
                let diff = 100.0 - touchedView.frame.origin.x
                cancelTxt.alpha = diff / 100
            } else if gestureRecognizer.state == .ended {
                if touchedView.frame.origin.x == 170 {
                    cancelImg.image = UIImage(named: "check")
                    cancelImg.frame(forAlignmentRect: CGRect(x: touchedView.frame.origin.x, y: 0, width: 50, height: 50))
                    cancelView.backgroundColor = .red
                    cancelTxt.text = "종료합니다"
                    cancelTxt.alpha = 1
                } else {
                    touchedView.frame.origin.x = 0
                    cancelTxt.alpha = 1
                }
            }
            
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        }
    }
}


