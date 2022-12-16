import UIKit

class DiaryDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var diary: Diary?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        guard let diary = diary else { return }
        titleLabel.text = diary.title
        contentTextView.text = diary.contents
        dateLabel.text = dateToString(date: diary.date)
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일 (EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    @IBAction func editBTN(_ sender: UIButton) {
        
    }
    
    
    @IBAction func deleteBTN(_ sender: UIButton) {
        
    }
    
}
