import UIKit

class OnboardingViewController: UIViewController {
    
    var currentPageIndex: Int = 0

    @IBOutlet weak var currentPageMark: UIPageControl!
    @IBOutlet weak var warningImage: UIImageView!
    @IBOutlet weak var introLabel1: UILabel!
    @IBOutlet weak var introLabel2: UILabel!
    @IBOutlet weak var nextPageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextPageButton.layer.cornerRadius = 16
    }
    
    @IBAction func showNextViewControllerButtonPressed(_ sender: UIButton) {
        currentPageIndex = currentPageIndex + 1
        if currentPageIndex == 1 {
            introLabel1.text = "꾸부정한 자세로 거북이가 된 당신."
            introLabel2.text = "거북이 껍데기에서 탈출하십시오"
            warningImage.image = UIImage(named: "onboarding2")
            currentPageMark.currentPage = 1
        } else if currentPageIndex == 2 {
            introLabel1.text = "꾸부기 탐지기가"
            introLabel2.text = "당신의 건강한 삶을 위해 도와줄게요!"
            nextPageButton.setTitle("시작하기", for: .normal)
            warningImage.image = UIImage(named: "onboarding3")
            currentPageMark.currentPage = 2
        } else if currentPageIndex == 3 {
            if let authorizationViewController = storyboard?.instantiateViewController(withIdentifier: "authorizationViewController") {
                authorizationViewController.modalPresentationStyle = .fullScreen
                present(authorizationViewController, animated: false)
            }
        }
    }
    
}
