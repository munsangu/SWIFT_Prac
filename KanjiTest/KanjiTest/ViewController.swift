import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var kanji: UILabel!
    var kanjiList = ["羽", "矢", "才", "台", "切", "話", "主", "君", "対"]
    var num = Int.random(in: 0...9)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kanji.text = kanjiList[num]
    }

    @IBAction func changeBTN(_ sender: UIButton) {
        num = Int.random(in: 0..<9)
        kanji.text = kanjiList[num]
    }
}

