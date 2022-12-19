import UIKit
import UserNotifications

class AlertListCell: UITableViewCell {
    
    var userNofiticationCenter = UNUserNotificationCenter.current()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBOutlet weak var meridiemLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var alertSwitch: UISwitch!
    
    @IBAction func alertSwitchToggle(_ sender: UISwitch) {
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data,
              var alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else { return }
        
        alerts[sender.tag].isOn = sender.isOn
        UserDefaults.standard.set(try? PropertyListEncoder().encode(alerts), forKey: "alerts")
        
        if sender.isOn {
            userNofiticationCenter.addNotificationRequest(by: alerts[sender.tag])
        } else {
            userNofiticationCenter.removePendingNotificationRequests(withIdentifiers: [alerts[sender.tag].id])
        }
    }
}
