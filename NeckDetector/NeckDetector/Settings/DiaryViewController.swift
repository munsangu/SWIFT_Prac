import UIKit

class DiaryViewController: UIViewController {
    
    @IBOutlet weak var calendarContainerView: UIView!
    
    lazy var dateView: UICalendarView = {
        var calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.wantsDateDecorations = true
        calendarView.locale = .current
        return calendarView
    }()
    
    @IBOutlet weak var levelView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "꾸북이 여정"
        
        let backButtonImage = UIImage(named: "arrowLeft")
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let backButtonBarItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backButtonBarItem
        
        calendarContainerView.addSubview(dateView)
        NSLayoutConstraint.activate([
            dateView.topAnchor.constraint(equalTo: calendarContainerView.topAnchor),
            dateView.leadingAnchor.constraint(equalTo: calendarContainerView.leadingAnchor),
            dateView.trailingAnchor.constraint(equalTo: calendarContainerView.trailingAnchor),
            dateView.bottomAnchor.constraint(equalTo: calendarContainerView.bottomAnchor),
        ])
        
        levelView.layer.cornerRadius = 16
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
