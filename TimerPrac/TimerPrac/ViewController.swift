import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animationLabel: UILabel!
    @IBOutlet weak var animationLabel2: UILabel!
    var timer: Timer?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let rotatingAngle: CGFloat = 30.0 * .pi / 180.0
        let rotatingAngle2: CGFloat = -30.0 * .pi / 180.0
        
        animationLabel.clipsToBounds = true
        animationLabel.layer.cornerRadius = animationLabel.bounds.size.width / 2
        animationLabel.backgroundColor = .black
        animationLabel.transform = CGAffineTransform(rotationAngle: rotatingAngle)
        
        animationLabel2.clipsToBounds = true
        animationLabel2.layer.masksToBounds = true
        animationLabel2.layer.cornerRadius = animationLabel2.bounds.size.width / 2
        animationLabel2.backgroundColor = .black
        animationLabel2.transform = CGAffineTransform(rotationAngle: rotatingAngle2)
        
    }
    
    @IBAction func animationStart(_ sender: UIButton) {
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(animation), userInfo: self, repeats: true)

    }
    
    @IBAction func animationStop(_ sender: UIButton) {
        
        timer?.invalidate()
        timer = nil
        
    }
    
    @objc func animation() {
        
        animationLabel.backgroundColor = .red
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.animationLabel.backgroundColor = .yellow
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.animationLabel.backgroundColor = .green
            }
        }
        
        animationLabel2.backgroundColor = .red
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.animationLabel2.backgroundColor = .yellow
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.animationLabel2.backgroundColor = .green
            }
        }
    }


}

