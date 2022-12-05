import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    weak var timer: Timer?
    
    var number = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        mainLabel.text = "Set the seconds!"
        // set center of slider
        slider.setValue(0.5, animated: true)
        
    }
 
    @IBAction func sliderChanged(_ sender: UISlider) {
        // change the mainLabel by value of slider
         mainLabel.text = "\(String(Int(sender.value * 60)))s"
        number = Int(sender.value * 60)
    }
    
    @IBAction func startBTN(_ sender: UIButton) {
        // Do something every second passes
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {[self] _ in
        // code (you want to repeat)
            if number > 0 {
                number -= 1
                // change the value of slide and mainLabel
                slider.value = Float(number) / Float(60)
                mainLabel.text = "\(number)s"
            } else {
                number = 0
                // stop timer
                timer?.invalidate()
                // play system sound
                AudioServicesPlayAlertSound(SystemSoundID(1322))
            }
        }
        
//        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(after1SecFunc), userInfo: nil, repeats: true)
    }
    
//    @objc func after1SecFunc() {
//        // code (you want to repeat)
//            if number > 0 {
//                number -= 1
//                // change the value of slide and mainLabel
//                slider.value = Float(number) / Float(60)
//                mainLabel.text = "\(number)s"
//            } else {
//                number = 0
//                // stop timer
//                timer?.invalidate()
//                // play system sound
//                AudioServicesPlayAlertSound(SystemSoundID(1322))
//            }
//        }
//    }
    
    @IBAction func resetBTN(_ sender: UIButton) {
        // initialization
        mainLabel.text = "Set the seconds!"
        slider.setValue(0.5, animated: true)
        number = 0
        timer?.invalidate()
    }
    
}

