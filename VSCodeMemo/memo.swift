import UIKit
import Network

class ViewController: UIViewController, NetServiceBrowserDelegate {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    let netServiceBrowser = NetServiceBrowser()
    var foundTVServies = [NetService]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        netServiceBrowser.delegate = self
        netServiceBrowser.searchForServices(ofType: "_googlecast._tcp", inDomain: "local.")
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        foundTVServies.append(service)
        
        if !moreComing {
            for tvService in foundTVServies {
                print("Found Android TV: \(tvService.name)")
            }
//            if let tvService = foundTVServies.first {
//
//            }
        }
    }    
}