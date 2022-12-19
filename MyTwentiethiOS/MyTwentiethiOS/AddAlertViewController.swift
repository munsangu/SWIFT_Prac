import UIKit

class AddAlertViewController: UIViewController {
    
    var pickedDate: ((_ date: Date) -> Void)?
    @IBOutlet weak var datePicker: UIDatePicker!
    
        
    @IBAction func cancelBTN(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func saveBTN(_ sender: UIBarButtonItem) {
        pickedDate?(datePicker.date)
        dismiss(animated: true)
    }
}
