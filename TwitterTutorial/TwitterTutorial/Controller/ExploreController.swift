import UIKit

class ExploreController: UIViewController {
    
    // MARK: - Properties
     
    // MARK: - Lifecycle
     override func viewDidLoad() {
         super.viewDidLoad()
         
         self.configureUI()
     }
     
     // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "Explore"
    }
}
