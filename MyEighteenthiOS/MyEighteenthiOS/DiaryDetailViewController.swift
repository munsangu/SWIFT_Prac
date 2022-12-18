import UIKit

class DiaryDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    var starButton: UIBarButtonItem?
        
    var diary: Diary?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        NotificationCenter.default.addObserver(self, selector: #selector(starDiaryNotification(_:)), name: NSNotification.Name("starDiary"),
          object: nil)
    }
    
    private func configureView() {
        guard let diary = diary else { return }
        titleLabel.text = diary.title
        contentsTextView.text = diary.contents
        dateLabel.text = dateToString(date: diary.date)
        starButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(starBTN))
        starButton?.image = diary.isStar ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        starButton?.tintColor = .yellow
        navigationItem.rightBarButtonItem = starButton
    }
    
    @objc func starBTN() {
        guard let isStar = diary?.isStar else { return }
        if isStar {
            starButton?.image = UIImage(systemName: "star")
        } else {
            starButton?.image = UIImage(systemName: "star.fill")
        }
        diary?.isStar = !isStar
        NotificationCenter.default.post(name: NSNotification.Name("starDiary"), object: ["diary": diary, "isStar" : diary?.isStar ?? false, "uuidString": diary?.uuidString], userInfo: nil)
    }
    
    @objc func starDiaryNotification(_ notification: Notification) {
      guard let starDiary = notification.object as? [String: Any], let isStar = starDiary["isStar"] as? Bool, let uuidString = starDiary["uuidString"] as? String, let diary = self.diary  else { return }
      if diary.uuidString == uuidString {
        self.diary?.isStar = isStar
        self.configureView()
      }
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-MM-dd(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
        
    @IBAction func editBTN(_ sender: UIButton) {
        
        guard let viewController = storyboard?.instantiateViewController(identifier: "WriteDiaryViewController") as? WriteDiaryViewController else { return }
        guard let indexPath = indexPath, let diary = diary else { return }
        viewController.diaryEditorMode = .edit(indexPath, diary)
        NotificationCenter.default.addObserver(self, selector: #selector(editDiaryNotification(_:)), name: NSNotification.Name("editDiary"), object: nil)
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @objc func editDiaryNotification(_ notification: Notification) {
        guard let diary = notification.object as? Diary else { return }
        self.diary = diary
        configureView()
    }
    
    @IBAction func removeBTN(_ sender: UIButton) {
        
        guard let uuidString = self.diary?.uuidString else { return }
        NotificationCenter.default.post(name: NSNotification.Name("deleteDiary"), object: uuidString, userInfo: nil)
        navigationController?.popViewController(animated: true)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
