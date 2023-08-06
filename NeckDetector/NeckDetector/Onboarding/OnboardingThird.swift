import UIKit

class OnboardingThird: UIViewController {
    
    let stackView = UIStackView()
    let stackView2 = UIStackView()
    
    let imageView = UIImageView()
    let firstLabel = UILabel()
    let secondLabel = UILabel()
    
    let button = UIButton()
    
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
        imageView.image = UIImage(named: "onboarding3")
        imageView.contentMode = .scaleAspectFill
                
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        firstLabel.text = "어떻게 해야할지 모르겠다면 꾸북이 탐지기가"
        firstLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.text = "건강한 삶을 위해 도와줄게요!"
        secondLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        secondLabel.numberOfLines = 0
        
        let attributedString = NSMutableAttributedString(string: secondLabel.text!)
        let color = UIColor(cgColor: CGColor(red: 86 / 255, green: 124 / 255, blue: 37 / 255, alpha: 1))
        let range = NSRange(location: 0, length: 7)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        secondLabel.attributedText = attributedString
        
        button.setTitle("시작하기", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(cgColor: CGColor(red: 123 / 255, green: 220 / 255, blue: 0, alpha: 1))
        button.tintColor = .white
        button.addTarget(self, action: #selector(goAuthorizationViewController), for: .touchUpInside)
    }
    
    @objc func goAuthorizationViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let authorizationViewController = storyboard.instantiateViewController(withIdentifier: "authorizationViewController") as? AuthorizationViewController {
            authorizationViewController.modalPresentationStyle = .fullScreen
            self.present(authorizationViewController, animated: false)
        }
    }
    
    func layout() {
        stackView2.addArrangedSubview(firstLabel)
        stackView2.addArrangedSubview(secondLabel)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(stackView2)
        
        view.addSubview(stackView)
        view.addSubview(button)
        
        button.layer.cornerRadius = 16
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 360),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
        ])
    }
}
