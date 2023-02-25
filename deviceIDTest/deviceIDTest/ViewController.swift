import UIKit
import TAKUUID

// iOS 디바이스의 고유 아이디(UUID - KeyChain) -> 공장초기화를 하지않는 이상 앱을 삭제했다가 재설치를 하더라도 이 값은 그대로 유지 및 저장됨


class ViewController: UIViewController {

    @IBOutlet weak var uuidInTheKeyChain: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUUID()
    }
    
    private func initUUID() {
        TAKUUIDStorage.sharedInstance().migrate()
        
        uuidInTheKeyChain.text = TAKUUIDStorage.sharedInstance().findOrCreate()
    }


}

