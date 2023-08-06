import UIKit

class TotalSettingViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    let label1 = UILabel()
    let userName = UserDefaults.standard.string(forKey: "userNickName")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let userName = userName else { return }
        label1.text = "\(userName)님"
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .red
        label1.font = UIFont.systemFont(ofSize: 20, weight: .medium)
                
        firstView.addSubview(label1)
        
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 150),
            label1.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 16),
            label1.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -16),
            label1.bottomAnchor.constraint(equalTo: firstView.bottomAnchor, constant: -150),
        ])

    }
    
    @IBAction func retouchButtonTapped(_ sender: UIButton) {
        if let retouchingViewController = self.storyboard?.instantiateViewController(withIdentifier: "retouchingViewController") {
            navigationController?.pushViewController(retouchingViewController, animated: true)
        }
    }
    

}
