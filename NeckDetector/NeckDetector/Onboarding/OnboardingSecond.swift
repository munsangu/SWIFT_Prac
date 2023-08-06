import UIKit

class OnboardingSecond: UIViewController {
    
    let stackView = UIStackView()
    let stackView2 = UIStackView()
    
    let imageView = UIImageView()
    let pageControl = UIPageControl()
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
        imageView.image = UIImage(named: "onboarding2")
        imageView.contentMode = .scaleAspectFill
                
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        firstLabel.text = "꾸부정한 자세로 거북이가 된 당신."
        firstLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        let attributedString = NSMutableAttributedString(string: firstLabel.text!)
        let color = UIColor(cgColor: CGColor(red: 86 / 255, green: 124 / 255, blue: 37 / 255, alpha: 1))
        let range = NSRange(location: 0, length: 7)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        
        firstLabel.attributedText = attributedString
        
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.text = "거북이 껍데기에서 탈출하세요!"
        secondLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        secondLabel.numberOfLines = 0
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
