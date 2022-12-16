import UIKit

protocol WriteDiaryViewDelegate: AnyObject {
    func didSelectRegister(diary: Diary)
}

class WriteDiaryViewController: UIViewController {

    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var saveBTN: UIBarButtonItem!
    
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    weak var delegate: WriteDiaryViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContentsTextView()
        configureDatePicker()
        configureInputField()
        saveBTN.isEnabled = false
    }
    
    private func configureContentsTextView() {
        contentsTextView.layer.borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0).cgColor
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
        titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_ :)), for: .editingChanged)
        dateTextField.addTarget(self, action: #selector(dateTextFieldDidChange(_ :)), for: .editingChanged)
    }
    
    @IBAction func saveBTN(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text else { return }
        guard let contents = contentsTextView.text else { return }
        guard let date = diaryDate else { return }
        let diary = Diary(title: title, contents: contents, date: date, isFavorite: false)
        delegate?.didSelectRegister(diary: diary)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy년 MM월 dd일 (EEEEE)"
        formmater.locale = Locale(identifier: "ko_KR")
        diaryDate = datePicker.date
        dateTextField.text = formmater.string(from: datePicker.date)
        dateTextField.sendActions(for: .editingChanged)
    }
    
    @objc private func titleTextFieldDidChange(_ textField: UITextField) {
        validateInputField()
    }
    
    @objc private func dateTextFieldDidChange(_ textField: UITextField) {
        validateInputField()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func validateInputField() {
        saveBTN.isEnabled = !(titleTextField.text?.isEmpty ?? true) && !(dateTextField.text?.isEmpty ?? true) && !contentsTextView.text.isEmpty
    }
}

extension WriteDiaryViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        validateInputField()
    }
}
