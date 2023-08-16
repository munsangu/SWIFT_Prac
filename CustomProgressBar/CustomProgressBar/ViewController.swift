import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var customPrgoressBar: UIStackView!
    
    let customCircle = UIView()
    var rank: Int = 94
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customCircle.translatesAutoresizingMaskIntoConstraints = false
        customCircle.backgroundColor = .blue
        customCircle.layer.cornerRadius = 10
        
        print("StackViewWidth: \(customPrgoressBar.frame.width)")
        let convertRank: Double = Double(rank) / 100
        print("ConvertRank: \(convertRank)")
        let finalRank = customPrgoressBar.frame.width * CGFloat(convertRank)
        print("FinalRank: \(finalRank)")
        
        containerView.addSubview(customCircle)
        NSLayoutConstraint.activate([
            customCircle.widthAnchor.constraint(equalToConstant: 20),
            customCircle.heightAnchor.constraint(equalToConstant: 20),
            customCircle.topAnchor.constraint(equalTo: customPrgoressBar.topAnchor, constant: -5),
            customCircle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: finalRank),
        ])
    }


}

