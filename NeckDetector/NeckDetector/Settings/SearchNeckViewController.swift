import UIKit

class SearchNeckViewController: UIViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView()
    let menuStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "목 찾으러 가기"
        
        let backButtonImage = UIImage(named: "arrowLeft")
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let backButtonBarItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backButtonBarItem
        
        self.setupScrollView()
        self.setupMenuButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let selectedButton = menuStackView.arrangedSubviews.first as? UIButton {
            addBottomBorderToButton(button: selectedButton)
        }
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupMenuButtons() {
        menuStackView.axis = .horizontal
        menuStackView.spacing = 10
        menuStackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(menuStackView)
        
        NSLayoutConstraint.activate([
            menuStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            menuStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            menuStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            menuStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        let buttonTitle = ["데일리루틴", "장기루틴", "인기운동", "부위별운동", "마사지"]
        
        for i in 0...buttonTitle.count - 1 {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("\(buttonTitle[i])", for: .normal)
            button.setTitleColor(UIColor(cgColor: CGColor(red: 34 / 255, green: 34 / 255, blue: 34 / 255, alpha: 1)), for: .normal)
            button.tintColor = UIColor(cgColor: CGColor(red: 34 / 255, green: 34 / 255, blue: 34 / 255, alpha: 1))
            button.addTarget(self, action: #selector(menuButtonTapped(_:)), for: .touchUpInside)
            menuStackView.addArrangedSubview(button)
            button.widthAnchor.constraint(equalTo: button.heightAnchor, multiplier: 2.5).isActive = true
        }
    }
        
    @objc func menuButtonTapped(_ sender: UIButton) {
        for button in menuStackView.arrangedSubviews {
            if let button = button as? UIButton, button != sender {
                removeBottomBorderFromButton(button: button)
            }
        }
        if sender.layer.sublayers?.contains(where: { $0.name == "bottomBorder" }) ?? false {
            removeBottomBorderFromButton(button: sender)
        } else {
            addBottomBorderToButton(button: sender)
        }
    }
    
    func addBottomBorderToButton(button: UIButton) {
        let underlineLayer = CALayer()
        underlineLayer.backgroundColor = CGColor(red: 34 / 255, green: 34 / 255, blue: 34 / 255, alpha: 1)
        underlineLayer.frame = CGRect(x: 0, y: button.frame.size.height - 2, width: button.frame.size.width, height: 2)
        underlineLayer.name = "bottomBorder"
        button.layer.addSublayer(underlineLayer)
    }
    
    func removeBottomBorderFromButton(button: UIButton) {
        if let layers = button.layer.sublayers {
            for layer in layers {
                if layer.name == "bottomBorder" {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
        
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
