import UIKit

@IBDesignable
class RoundNumBTN: UIButton {
    @IBInspectable var isRound: Bool = false {
        didSet {
            if isRound {
                layer.cornerRadius = frame.height / 2
            }
        }
    }
}
