import UIKit

class NoticeViewController: UIViewController {

    var noticeContents: (title: String, detail: String, date: String)?
    
    @IBOutlet weak var noticeView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        noticeView.layer.cornerRadius = 6
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        guard let noticeContents = noticeContents else { return }
        titleLabel.text = noticeContents.title
        detailLabel.text = noticeContents.detail
        dateLabel.text = noticeContents.date
    }
    
    @IBAction func okayBTN(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
