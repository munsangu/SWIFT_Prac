import UIKit
import Kingfisher
import FirebaseDatabase
import FirebaseFirestoreSwift
import FirebaseFirestore

class CardListViewController: UITableViewController {
    // var ref:DatabaseReference! // Firebase Realtime Database
    var db = Firestore.firestore() // Firebase firestore Database
    
    var creditCardList: [CreditCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UITableView Cell Register
        let nibName = UINib(nibName: "CardListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CardListCell")
        
        // Realtime Database read
//        self.ref = Database.database().reference()
//        self.ref.observe(.value) { snapshot in
//            guard let value = snapshot.value as? [String: [String: Any]] else { return }
//            do {
//                let jsonData = try JSONSerialization.data(withJSONObject: value)
//                let cardData = try JSONDecoder().decode([String: CreditCard].self, from: jsonData)
//                let cardList = Array(cardData.values)
//                self.creditCardList = cardList.sorted { $0.rank < $1.rank }
//
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            } catch let error {
//                print("Error JSON Parsing \(error.localizedDescription)")
//            }
//        }
        
        // Firestore read
        db.collection("creditCardList").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else { print("Error Firestore fetching document \(String(describing: error))")
                return
            }
            
            self.creditCardList = documents.compactMap { doc -> CreditCard? in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: doc.data())
                    let creditCard = try JSONDecoder().decode(CreditCard.self, from: jsonData)
                    return creditCard
                } catch let error {
                    print("Error JSON Parsing \(error)")
                    return nil
                }
            }.sorted { $0.rank < $1.rank }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCardList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardListCell", for: indexPath) as? CardListCell else { return UITableViewCell() }
        cell.rankLabel.text = "\(creditCardList[indexPath.row].rank)위"
        cell.promotionLabel.text = "\(creditCardList[indexPath.row].promotionDetail.amount)만원 증정"
        cell.cardNameLabel.text = "\(creditCardList[indexPath.row].name)"
        
        let imageURL = URL(string: creditCardList[indexPath.row].cardImageURL)
        cell.cardImageView.kf.setImage(with: imageURL)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Move a detail display
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "CardDetailViewController") as? CardDetailViewController else { return }
        detailViewController.promotionDetail = creditCardList[indexPath.row].promotionDetail
        show(detailViewController, sender: nil)
        
        let cardID = creditCardList[indexPath.row].id
        // Realtime Database Write
        
        // 경로를 알고 있을 경우
        // ref.child("Item\(cardID)/isSelected").setValue(true)
        
        // 경로를 모를 경우
//        ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) { [weak self] snapshot in
//            guard let self = self, let value = snapshot.value as? [String: [String: Any]], let key = value.keys.first else { return }
//            self.ref.child("\(key)/isSelected").setValue(true)
//        }
               
        // Firestore Database Write

        // 경로를 알고 있을 경우
        db.collection("creditCardList").document("card\(cardID)").updateData(["isSelected" : true])
        
        // 경로를 모를 경우
        db.collection("creditCardList").whereField("id", isEqualTo: cardID).getDocuments { snapshot, _ in
            guard let document = snapshot?.documents.first else {
                print("Error Firestore fetching documnet")
                return
            }
            document.reference.updateData(["isSelected": true])
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let cardID = creditCardList[indexPath.row].id
            // Realtime Database Remove
//            ref.child("Item\(cardID)").removeValue()
            
//            ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) { [weak self] snapshot in
//                guard let self = self, let value = snapshot.value as? [String: [String: Any]], let key = value.keys.first else { return }
//                self.ref.child(key).removeValue()
//            }
            // Firestore Database Remove
//            db.collection("creditCardList").document("card\(cardID)").delete()
            
            db.collection("creditCardList").whereField("id", isEqualTo: cardID).getDocuments { snapshot, _ in
                guard let document = snapshot?.documents.first else {
                    print("Error")
                    return
                }
                document.reference.delete()
            }
        }
    }
}
