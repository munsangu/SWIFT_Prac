import UIKit

class DiaryCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        contentView.layer.cornerRadius = 3.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.black.cgColor
    }
}
