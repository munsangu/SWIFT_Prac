import UIKit

class CovidDetailViewController: UITableViewController {

    
    @IBOutlet weak var newCaseCell: UITableViewCell!
    @IBOutlet weak var totalCaseCell: UITableViewCell!
    @IBOutlet weak var curedCell: UITableViewCell!
    @IBOutlet weak var deadCell: UITableViewCell!
    @IBOutlet weak var rateCell: UITableViewCell!
    @IBOutlet weak var overseasInflowCell: UITableViewCell!
    @IBOutlet weak var localCell: UITableViewCell!
    
    var covidOverview: CovidOverview?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        guard let covidOverview = covidOverview else { return }
        title = covidOverview.countryName
        newCaseCell.detailTextLabel?.text = "\(covidOverview.newCase)"
        totalCaseCell.detailTextLabel?.text = "\(covidOverview.totalCase)"
        curedCell.detailTextLabel?.text = "\(covidOverview.recovered)"
        deadCell.detailTextLabel?.text = "\(covidOverview.death)"
        rateCell.detailTextLabel?.text = "\(covidOverview.percentage)"
        overseasInflowCell.detailTextLabel?.text = "\(covidOverview.newFcase)"
        localCell.detailTextLabel?.text = "\(covidOverview.newCcase)"
    }
}
