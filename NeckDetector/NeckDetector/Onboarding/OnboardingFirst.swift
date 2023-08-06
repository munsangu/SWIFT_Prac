import UIKit

class OnboardingFirst: UIViewController {
    
    let stackView = UIStackView()
    let stackView2 = UIStackView()
    
    let imageView = UIImageView()
    let firstLabel = UILabel()
    let secondLabel = UILabel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.style()
        self.layout()
    }
    
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 150
        
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        stackView2.axis = .vertical
        stackView2.alignment = .center
        stackView2.spacing = 5
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "onboarding1")
        imageView.contentMode = .scaleAspectFill
 
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        firstLabel.text = "이걸 보고 있는 지금."
        firstLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.text = "당신은 어떤 모습을 하고 있나요?"
        secondLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        secondLabel.numberOfLines = 0
        
        let attributedString = NSMutableAttributedString(string: secondLabel.text!)
        let color = UIColor(cgColor: CGColor(red: 86 / 255, green: 124 / 255, blue: 37 / 255, alpha: 1))
        let range = NSRange(location: 4, length: 6)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        
        secondLabel.attributedText = attributedString
    }
    
    func layout() {
        stackView2.addArrangedSubview(firstLabel)
        stackView2.addArrangedSubview(secondLabel)
    
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(stackView2)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
    }
    
}
