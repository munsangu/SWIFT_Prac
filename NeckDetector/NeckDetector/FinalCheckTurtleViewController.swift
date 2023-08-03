import UIKit

class FinalCheckTurtleViewController: UIViewController {
    
    @IBOutlet weak var recheckButton: UIButton!
    @IBOutlet weak var neckStretchButton: UIButton!
    
    @IBOutlet weak var imageSaveButton: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recheckButton.layer.cornerRadius = 16
        neckStretchButton.layer.cornerRadius = 16
    }
    
    @IBAction func recheckButtonTapped(_ sender: UIButton) {
//        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "cameraViewController") {
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: false)
//        }
    }
    
    
    @IBAction func neckStretchButtonTapped(_ sender: UIButton) {
        
    }
    
    
}
