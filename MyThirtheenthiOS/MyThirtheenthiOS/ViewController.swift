import UIKit
import AudioToolbox

enum TimerStatus {
    case start
    case pause
    case end
}

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelBTN: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var startBTN: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    // date picker의 default가 1분(60초)
    var duration = 60
    var timerStatus: TimerStatus = .end
    var timer: DispatchSourceTimer?
    var currnetSeconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStartBTN()
    }
    
    func setTimerInfoViewVisable(isHidden: Bool) {
        timerLabel.isHidden = isHidden
        progressView.isHidden = isHidden
    }
    
    func configureStartBTN() {
        startBTN.setTitle("Start", for: .normal)
        startBTN.setTitle("Pause", for: .selected)
    }
    
    func startTimer() {
        if timer == nil {
            timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            timer?.schedule(deadline: .now(), repeating: 1)
            timer?.setEventHandler(handler: { [weak self] in
                guard let self = self else { return }
                self.currnetSeconds -= 1
                let hour = self.currnetSeconds / 3600
                let minute = (self.currnetSeconds % 3600) / 60
                let second = (self.currnetSeconds % 3600) % 60
                self.timerLabel.text = String(format: "%02d:%02d:%02d", hour, minute, second)
                self.progressView.progress = Float(self.currnetSeconds) / Float(self.duration)
                UIView.animate(withDuration: 0.5, delay: 0) {
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi)
                }
                UIView.animate(withDuration: 0.5, delay: 0.5) {
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi * 2)
                }
                if self.currnetSeconds <= 0 {
                    self.stopTimer()
                    AudioServicesPlaySystemSound(1005)
                }
            })
            timer?.resume()
        }
    }
    
    func stopTimer() {
        if timerStatus == .pause {
            timer?.resume()
        }
        timerStatus = .end
        cancelBTN.isEnabled = false
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.timerLabel.alpha = 0
            self.progressView.alpha = 0
            self.datePicker.alpha = 1
            self.imageView.transform = .identity
        }
        startBTN.isSelected = false
        timer?.cancel()
        timer = nil
    }

    @IBAction func cancelBTN(_ sender: UIButton) {
        switch timerStatus {
        case .start, .pause:
            stopTimer()
        case .end:
            break
        }
    }
    
    @IBAction func startBTN(_ sender: UIButton) {
        duration = Int(datePicker.countDownDuration)
        switch timerStatus {
        case .start:
            timerStatus = .pause
            startBTN.isSelected = false
            timer?.suspend()
        case .end:
            currnetSeconds = duration
            timerStatus = .start
            UIView.animate(withDuration: 0.5, delay: 0) {
                self.timerLabel.alpha = 1
                self.progressView.alpha = 1
                self.datePicker.alpha = 0
            }
            startBTN.isSelected = true
            cancelBTN.isEnabled = true
            startTimer()
        case .pause:
            timerStatus = .start
            startBTN.isSelected = true
            timer?.resume()
        }
    }
}

