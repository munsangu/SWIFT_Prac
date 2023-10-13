import UIKit

class BurgerMenuViewController: UIViewController {
    
    var viewController: ViewController?
    
    private let applogoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "appLogo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let closeImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "close"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let mainButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "house"), for: .normal)
        button.tintColor = .white
        button.setTitle("   메인으로", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont(name: "SUIT-Bold", size: 24)
        return button
    }()
    
    private let borderImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "border2"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let listButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "list"), for: .normal)
        button.tintColor = .white
        button.setTitle("   데이터 리스트", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont(name: "SUIT-Bold", size: 24)
        return button
    }()
    
    private let applogoImageView2: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "appLogo2"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let copylightImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "copylight"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backgroundSetup()
        self.configureUI()
        
        mainButton.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
        listButton.addTarget(self, action: #selector(listButtonTapped), for: .touchUpInside)
    }
    
    func backgroundSetup() {
        view.backgroundColor = UIColor(cgColor: CGColor(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1))
    }
    
    func configureUI() {
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(didCloseTapped))
        tap1.numberOfTapsRequired = 1
        closeImageView.isUserInteractionEnabled = true
        closeImageView.addGestureRecognizer(tap1)
        
        view.addSubview(applogoImageView)
        view.addSubview(closeImageView)
        
        NSLayoutConstraint.activate([
            applogoImageView.widthAnchor.constraint(equalToConstant: 80),
            applogoImageView.heightAnchor.constraint(equalToConstant: 24),
            applogoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 23),
            applogoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            closeImageView.widthAnchor.constraint(equalToConstant: 24),
            closeImageView.heightAnchor.constraint(equalToConstant: 24),
            closeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 23),
            closeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
        
        view.addSubview(mainButton)
        view.addSubview(borderImageView)
        view.addSubview(listButton)
        NSLayoutConstraint.activate([
            mainButton.topAnchor.constraint(equalTo: applogoImageView.bottomAnchor, constant: 130),
            mainButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            borderImageView.heightAnchor.constraint(equalToConstant: 2),
            borderImageView.topAnchor.constraint(equalTo: mainButton.bottomAnchor, constant: 30),
            borderImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            listButton.topAnchor.constraint(equalTo: borderImageView.bottomAnchor, constant: 30),
            listButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        ])
        
        view.addSubview(applogoImageView2)
        view.addSubview(copylightImageView)
        NSLayoutConstraint.activate([
            applogoImageView2.widthAnchor.constraint(equalToConstant: 44),
            applogoImageView2.heightAnchor.constraint(equalToConstant: 24),
            applogoImageView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            applogoImageView2.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            copylightImageView.widthAnchor.constraint(equalToConstant: 87),
            copylightImageView.heightAnchor.constraint(equalToConstant: 7),
            copylightImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            copylightImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
    }
    
    @objc func didCloseTapped() {
        UIView.animate(withDuration: 0.3) {
            guard let isStatus = self.viewController?.iswifiImageAndLabelStatus, let isList = self.viewController?.isListViewStatus else { return }
            self.view.frame.origin.x = self.view.bounds.width
            
            if isStatus {
                self.viewController?.wifiImageView.alpha = 1
                self.viewController?.connectLabel.alpha = 1
            } else {
                self.viewController?.wifiImageView.alpha = 0
                self.viewController?.connectLabel.alpha = 0
                if isList {
                    self.viewController?.arrowleftImageView.alpha = 1
                    self.viewController?.nowYearAndMonth.alpha = 1
                    self.viewController?.arrowrightImageView.alpha = 1
                    self.viewController?.tableContainerView.alpha = 1
                    
                    self.viewController?.nowDateLabel.alpha = 0
                    self.viewController?.resultImageView.alpha = 0
                    self.viewController?.resultStackView.alpha = 0
                    self.viewController?.resultLabel.alpha = 0
//                    self.viewController?.dataSaveButton.alpha = 0
                } else {
                    self.viewController?.arrowleftImageView.alpha = 0
                    self.viewController?.nowYearAndMonth.alpha = 0
                    self.viewController?.arrowrightImageView.alpha = 0
                    self.viewController?.tableContainerView.alpha = 0
                    
                    self.viewController?.nowDateLabel.alpha = 1
                    self.viewController?.resultImageView.alpha = 1
                    self.viewController?.resultStackView.alpha = 1
                    self.viewController?.resultLabel.alpha = 1
//                    self.viewController?.dataSaveButton.alpha = 1
                }
            }
        }
    }
    
    @objc func mainButtonTapped() {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.x = self.view.bounds.width
            self.viewController?.iswifiImageAndLabelStatus = true
            self.viewController?.isListViewStatus = false
            self.viewController?.wifiImageView.alpha = 1
            self.viewController?.wifiImageView.image = UIImage(named: "connect")
            self.viewController?.connectLabel.alpha = 1
            self.viewController?.connectLabel.text = "장비가 연결되지\n않았습니다."
            self.viewController?.applogoImageView.alpha = 1
            self.viewController?.moveBackImageView.alpha = 0
            self.viewController?.moveBackLabel.alpha = 0
            self.viewController?.nowYearAndMonth.alpha = 0
            self.viewController?.tableContainerView.alpha = 0
            self.viewController?.arrowleftImageView.alpha = 0
            self.viewController?.arrowrightImageView.alpha = 0
            guard let connectStatus = self.viewController?.isConnected else { return }
            if connectStatus {
                self.viewController?.settingCollectView()
            } else {
                self.viewController?.configureUI()
            }
        }
    }
    
    @objc func listButtonTapped() {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.x = self.view.bounds.width
            self.viewController?.iswifiImageAndLabelStatus = false
            self.viewController?.isListViewStatus = true
            self.viewController?.wifiImageView.alpha = 0
            self.viewController?.connectLabel.alpha = 0
            self.viewController?.applogoImageView.alpha = 1
            self.viewController?.moveBackImageView.alpha = 0
            self.viewController?.moveBackLabel.alpha = 0
            self.viewController?.nowYearAndMonth.alpha = 1
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM"
            let currentDate = Date()
            let formattedDate = dateFormatter.string(from: currentDate)
            self.viewController?.nowYearAndMonth.text = formattedDate
            self.viewController?.filteredData = (self.viewController?.finalData.filter { $0.contains(self.viewController?.nowYearAndMonth.text ?? "") })!
            self.viewController?.historyTableView.reloadData()
            self.viewController?.tableContainerView.alpha = 1
            self.viewController?.arrowleftImageView.alpha = 1
            self.viewController?.arrowrightImageView.alpha = 1
        }
    }
    
}
