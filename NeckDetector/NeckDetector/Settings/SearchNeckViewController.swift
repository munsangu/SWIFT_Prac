import UIKit

class SearchNeckViewController: UIViewController {
    
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
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
