import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var diaryList = [Diary]() {
        didSet {
            saveDiaryList()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        loadDiaryList()
        NotificationCenter.default.addObserver(self, selector: #selector(editDiaryNotification(_:)), name: NSNotification.Name("editDiary"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(starDiaryNotification(_:)), name: NSNotification.Name("starDiary"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteDiaryNotification(_:)), name: Notification.Name("deleteDiary"), object: nil)
    }
    
    @objc func editDiaryNotification(_ notification: Notification) {
        guard let diary = notification.object as? Diary, let index = diaryList.firstIndex(where: { $0.uuidString == diary.uuidString }) else { return }
        diaryList[index] = diary
        diaryList = self.diaryList.sorted(by: {
          $0.date.compare($1.date) == .orderedDescending
        })
        self.collectionView.reloadData()
    }
    
    @objc func starDiaryNotification(_ notification: Notification) {
        guard let starDiary = notification.object as? [String: Any], let isStar = starDiary["isStar"] as? Bool, let uuidString = starDiary["uuidString"] as? String, let index = self.diaryList.firstIndex(where: { $0.uuidString == uuidString }) else { return }
        diaryList[index].isStar = isStar
    }
    
    @objc func deleteDiaryNotification(_ notification: Notification) {
      guard let uuidString = notification.object as? String, let index = diaryList.firstIndex(where: { $0.uuidString == uuidString }) else { return }
        diaryList.remove(at: index)
        collectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
    }
    
    private func configureCollectionView() {
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let writeDiaryViewController = segue.destination as? WriteDiaryViewController {
            writeDiaryViewController.delegate = self
        }
    }
    
    private func saveDiaryList() {
        let date = diaryList.map {
            [
                "uuidString": $0.uuidString,
                "title": $0.title,
                "contents": $0.contents,
                "date": $0.date,
                "isStar": $0.isStar
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(date, forKey: "diaryList")
    }
    
    private func loadDiaryList() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "diaryList") as? [[String: Any]] else { return }
        diaryList = data.compactMap{
            guard let uuidString = $0["uuidString"] as? String, let title = $0["title"] as? String, let contents = $0["contents"] as? String, let date = $0["date"] as? Date, let isStar = $0["isStar"] as? Bool else { return nil }
            return Diary(uuidString: uuidString, title: title, contents: contents, date: date, isStar: isStar)
        }
        diaryList = diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-MM-dd(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diaryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiaryCell", for: indexPath) as? DiaryCell else { return UICollectionViewCell() }
        let diary = diaryList[indexPath.row]
//        print(diary)
        cell.titleLabel.text = diary.title
//        print(diary.title)
        cell.dateLabel.text = dateToString(date: diary.date)
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 20, height: 200)
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = storyboard?.instantiateViewController(identifier: "DiaryDetailViewController") as? DiaryDetailViewController else { return }
        let diary = diaryList[indexPath.row]
        viewController.diary = diary
        viewController.indexPath = indexPath
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension ViewController: WriteDiaryViewDelegate {
    
    func didSelectRegister(diary: Diary) {
        diaryList.append(diary)
        diaryList = diaryList.sorted(by: {$0.date.compare($1.date) == .orderedDescending})
        collectionView.reloadData()
    }
    
}
