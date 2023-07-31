import UIKit

class ConversationsController: UIViewController {
    
    // MARK: - Properties
     
    // MARK: - Lifecycle
     override func viewDidLoad() {
         super.viewDidLoad()
         
         self.configureUI()
     }
     
     // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "Messages"
    }
}
