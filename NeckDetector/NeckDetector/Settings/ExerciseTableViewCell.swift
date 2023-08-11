
import UIKit

class ExerciseTableViewCell: UITableViewCell {

    static let identifier = "ExerciseTableViewCell"
    
    private let imageSections: [[String]] = [
        ["exercise5", "exercise6", "exercise7"],
        ["exercise8", "exercise9", "exercise1"],
        ["exercise2", "exercise3", "exercise4"],
    ]
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 250)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    } ()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        contentView.backgroundColor = .clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = CGRect(x: contentView.bounds.origin.x + 15, y: contentView.bounds.origin.y, width: contentView.bounds.width, height: contentView.bounds.height)
    }
    
}

extension ExerciseTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let imageView = UIImageView(frame: cell.contentView.bounds)
        imageView.image = UIImage(named: imageSections[indexPath.section][indexPath.row])
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        cell.layer.cornerRadius = 12
        
        cell.contentView.addSubview(imageView)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageSections[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
