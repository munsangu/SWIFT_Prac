import UIKit

enum DiaryEditorMode {
    
    case new
    case edit(IndexPath, Diary)
    
}

protocol WriteDiaryViewDelegate: AnyObject {
    
    func didSelectRegister(diary: Diary)
    
}

class WriteDiaryViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    weak var delegate: WriteDiaryViewDelegate?
    var diaryEditorMode: DiaryEditorMode = .new
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContentsTextView()
        configureDatePicker()
        confirmButton.isEnabled = false
        configureInputField()
        cofigureEditMode()
    }
    
    private func cofigureEditMode() {
        
        switch diaryEditorMode {
        case let .edit(_, diary):
            titleTextField.text = diary.title
            contentsTextView.text = diary.contents
            dateTextField.text = dateToString(date: diary.date)
            diaryDate = diary.date
            confirmButton.title = "Edit"
        default:
            break
        }
        
    }
    
    private func configureContentsTextView() {
        let borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        contentsTextView.layer.borderColor = borderColor.cgColor
        contentsTextView.layer.borderWidth = 0.5
        contentsTextView.layer.cornerRadius = 5.0
    }
    
    private func configureDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        dateTextField.inputView = datePicker
    }
    
    private func configureInputField() {
        contentsTextView.delegate = self
        titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
        dateTextField.addTarget(self, action: #selector(dateTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @IBAction func confirmButton(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text, let contents = contentsTextView.text, let date = diaryDate  else { return }
        
        switch diaryEditorMode {
        case .new:
            let diary = Diary(uuidString: UUID().uuidString, title: title, contents: contents, date: date, isStar: false)
            delegate?.didSelectRegister(diary: diary)
        case let .edit(indexPath, diary):
            let diary = Diary(uuidString: diary.uuidString, title: title, contents: contents, date: date, isStar: diary.isStar)
            NotificationCenter.default.post(name: NSNotification.Name("editDiary"), object: diary, userInfo: nil)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy-MM-dd(EEEEE)"
        formmater.locale = Locale(identifier: "ko_KR")
        diaryDate = datePicker.date
        dateTextField.text = formmater.string(from: datePicker.date)
        dateTextField.sendActions(for: .editingChanged)
    }
    
    @objc private func titleTextFieldDidChange(_ textField: UITextField) {
        vaildateInputField()
    }
    
    @objc private func dateTextFieldDidChange(_ textField: UITextField) {
        vaildateInputField()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func vaildateInputField() {
        confirmButton.isEnabled = !(titleTextField.text?.isEmpty ?? true) && !(dateTextField.text?.isEmpty ?? true) && !contentsTextView.text.isEmpty
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-MM-dd(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}

extension WriteDiaryViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        vaildateInputField()
    }
}
