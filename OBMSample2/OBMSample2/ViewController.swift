import UIKit
import Foundation
import CoreBluetooth
import CoreData

class ViewController: UIViewController {
    
    // UI
    let applogoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "appLogo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let moveBackImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "moveBack"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let moveBackLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "리스트"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-Bold", size: 20)
        return label
    }()
    
    private let burgerImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "burgerMenu"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let arrowleftImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "arrow_left"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let arrowrightImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "arrow_right"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nowYearAndMonth: UILabel = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = formattedDate
        label.textColor = .white
        label.font = UIFont(name: "Oswald-Light", size: 32)
        label.widthAnchor.constraint(equalToConstant: 110).isActive = true
        return label
    }()
    
    let tableContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let wifiImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "connect"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let connectLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.text = "장비가 연결되지\n않았습니다."
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-Bold", size: 32)
        return label
    }()
    
    private let testBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("저장하기", for: .normal)
        button.backgroundColor = .green
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 16)
        return button
    }()
    
    private let testBtn2: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("기기 데이터 조회하기", for: .normal)
        button.backgroundColor = .yellow
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 16)
        return button
    }()
    
    private let testBtn3: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("기기 데이터 삭제하기", for: .normal)
        button.backgroundColor = .red
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 16)
        return button
    }()
    
    private let voltImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "volt")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor(white: 1, alpha: 0.6)
        return imageView
    }()
    
    private let voltLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "이상전압"
        label.textColor = UIColor(white: 1, alpha: 0.6)
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-Bold", size: 14)
        return label
    }()
    
    private let voltValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "6"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Oswald-Light", size: 40)
        return label
    }()
    
    private let borderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "border")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor(white: 1, alpha: 0.6)
        return imageView
    }()
    
    private let electricCurrentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "volt")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor(white: 1, alpha: 0.6)
        return imageView
    }()
    
    private let electricCurrentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "이상전류"
        label.textColor = UIColor(white: 1, alpha: 0.6)
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-Bold", size: 14)
        return label
    }()
    
    private let electricCurrentValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "8"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Oswald-Light", size: 40)
        return label
    }()
    
    private let borderImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "border")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor(white: 1, alpha: 0.6)
        return imageView
    }()
    
    private let temperatureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "temperature")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor(white: 1, alpha: 0.6)
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "이상온도"
        label.textColor = UIColor(white: 1, alpha: 0.6)
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-Bold", size: 14)
        return label
    }()
    
    private let temperatureValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Oswald-Light", size: 40)
        return label
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.text = "총 16건의\n신호를 감지했습니다."
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-Bold", size: 32)
        return label
    }()
    
//    let dataSaveButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setImage(UIImage(named: "export"), for: .normal)
//        button.setTitle(" 데이터 내보내기", for: .normal)
//        button.tintColor = .white
//        button.titleLabel?.textColor = .white
//        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 16)
//        button.layer.cornerRadius = 8
//        return button
//    }()
    
    let historyTableView = UITableView()
    let nowDateLabel = UILabel()
    let resultImageView = UIImageView()
    var resultStackView = UIStackView()
    
    let container = UIView()
    let gradientLayer = CAGradientLayer()
    
    var burgerMenuViewController: BurgerMenuViewController?
    
    var iswifiImageAndLabelStatus = true
    var isListViewStatus = false
    
    var isConnected = false
    // Bluetooth
//    var testArray = ["2023.10.11 / 08:00:00", "2023.10.11 / 09:00:00", "2023.10.11 / 10:00:00",
//                     "2023.10.11 / 08:00:00", "2023.10.11 / 09:00:00", "2023.10.11 / 10:00:00", "2023.10.11 / 08:00:00", "2023.10.11 / 09:00:00", "2023.10.11 / 10:00:00", "2023.10.11 / 08:00:00", "2023.10.11 / 09:00:00", "2023.10.11 / 10:00:00",
//                     "2023.11.11 / 09:00:00", "2023.09.11 / 09:00:00"
//    ]
    
    var filteredData: [String] = []
    var finalData: [String] = []
    
    private var centralManager: CBCentralManager!
    private var peripheral: CBPeripheral?
    private var reqCharacteristic: CBCharacteristic?
    
    let REQCharacteristicUUID = CBUUID(string: "0000fff3-0000-1000-8000-00805f9b34fb")
    let RSPCharacteristicUUID = CBUUID(string: "0000fff4-0000-1000-8000-00805f9b34fb")
    
    var packetTimer: Timer?
    var packetTimer2: Timer?
    var packetTimer3: Timer?
    var packetTimer4: Timer?
    var packetTimer5: Timer?
    
    var seq: UInt8 = 0x00
    
    let koreanTimeZone = TimeZone(identifier: "Asia/Seoul")
    var currentDate = Date()
    
    var logEntries: [String] = []
    var coreDataEntries: [Entity] = []
    
    var extractedString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.backgrountThemeSetting()
        self.configureUI()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        self.coreDataArrayUpdate()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        
//        container.frame = dataSaveButton.bounds
//        container.layer.cornerRadius = dataSaveButton.layer.cornerRadius
//        container.layer.masksToBounds = true
//        dataSaveButton.addSubview(container)
//        dataSaveButton.sendSubviewToBack(container)
//        
//        gradientLayer.frame = container.bounds
//        gradientLayer.colors = [UIColor(red: 0.2, green: 0.48, blue: 1.0, alpha: 1.0).cgColor,
//                                UIColor(red: 0.18, green: 0.36, blue: 0.69, alpha: 1.0).cgColor]
//        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
//        container.layer.insertSublayer(gradientLayer, at: 0)
//        
//        container.layer.shadowOffset = CGSize(width: 0, height: 3)
//        container.layer.shadowColor = UIColor.black.cgColor
//        container.layer.shadowOpacity = 0.3
//        container.layer.shadowRadius = 10
//    }
    
    func coreDataArrayUpdate() {
        let context = CoreDataStack.shared.viewContext
        let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
        
        do {
            let fetchedLogEntries = try context.fetch(fetchRequest)
            for logEntry in fetchedLogEntries {
                let savedTime = logEntry.savedTime
                let savedData = logEntry.savedData
                let combinedValue = "\(savedTime) : \(savedData)"
                filteredData.append(combinedValue)
            }
//            print(filteredData)
            finalData = filteredData
        } catch {
            print("Error fetching log entries: \(error)")
        }
    }
    
    func backgrountThemeSetting() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "backgroundTheme")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
    }
    
    func configureUI() {
        view.addSubview(applogoImageView)
        view.addSubview(moveBackImageView)
        view.addSubview(moveBackLabel)
        view.addSubview(burgerImageView)
        view.addSubview(nowYearAndMonth)
        view.addSubview(arrowleftImageView)
        view.addSubview(arrowrightImageView)
        view.addSubview(tableContainerView)
        view.addSubview(testBtn)
        view.addSubview(testBtn2)
        view.addSubview(testBtn3)
        
        moveBackImageView.alpha = 0
        moveBackLabel.alpha = 0
        arrowleftImageView.alpha = 0
        arrowrightImageView.alpha = 0
        nowYearAndMonth.alpha = 0
        tableContainerView.alpha = 0
        
        testBtn.addTarget(self, action: #selector(testButtonTapped), for: .touchUpInside)
        testBtn2.addTarget(self, action: #selector(testButton2Tapped), for: .touchUpInside)
        testBtn3.addTarget(self, action: #selector(testButton3Tapped), for: .touchUpInside)
        
        burgerMenuViewController = BurgerMenuViewController()
        burgerMenuViewController?.view.frame = CGRect(x: view.bounds.width, y: 0, width: view.bounds.width, height: UIScreen.main.bounds.height)
        self.addChild(burgerMenuViewController!)
        view.addSubview(burgerMenuViewController!.view)
        burgerMenuViewController?.viewController = self
        burgerMenuViewController?.didMove(toParent: self)
        
        let arrowLeftTap = UITapGestureRecognizer(target: self, action: #selector(didArrowLeftTapped))
        arrowLeftTap.numberOfTapsRequired = 1
        arrowleftImageView.isUserInteractionEnabled = true
        arrowleftImageView.addGestureRecognizer(arrowLeftTap)
        
        let arrowRightTap = UITapGestureRecognizer(target: self, action: #selector(didArrowRightTapped))
        arrowRightTap.numberOfTapsRequired = 1
        arrowrightImageView.isUserInteractionEnabled = true
        arrowrightImageView.addGestureRecognizer(arrowRightTap)
        
        let moveBackTap = UITapGestureRecognizer(target: self, action: #selector(didMoveBackTapped))
        moveBackTap.numberOfTapsRequired = 1
        moveBackImageView.isUserInteractionEnabled = true
        moveBackImageView.addGestureRecognizer(moveBackTap)
        
        let burgerMenuTap = UITapGestureRecognizer(target: self, action: #selector(didBurgerMenuTapped))
        burgerMenuTap.numberOfTapsRequired = 1
        burgerImageView.isUserInteractionEnabled = true
        burgerImageView.addGestureRecognizer(burgerMenuTap)
        
        historyTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        historyTableView.translatesAutoresizingMaskIntoConstraints = false
        historyTableView.backgroundColor = .clear
        historyTableView.separatorStyle = .singleLine
        historyTableView.separatorColor = .lightGray
        historyTableView.delegate = self
        historyTableView.dataSource = self
        tableContainerView.addSubview(historyTableView)
        
        view.addSubview(wifiImageView)
        view.addSubview(connectLabel)
        
        NSLayoutConstraint.activate([
            applogoImageView.widthAnchor.constraint(equalToConstant: 80),
            applogoImageView.heightAnchor.constraint(equalToConstant: 24),
            applogoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 23),
            applogoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            moveBackImageView.widthAnchor.constraint(equalToConstant: 24),
            moveBackImageView.heightAnchor.constraint(equalToConstant: 24),
            moveBackImageView.topAnchor.constraint(equalTo: applogoImageView.topAnchor),
            moveBackImageView.leadingAnchor.constraint(equalTo: applogoImageView.leadingAnchor),
            
            moveBackLabel.topAnchor.constraint(equalTo: applogoImageView.topAnchor),
            moveBackLabel.leadingAnchor.constraint(equalTo: moveBackImageView.trailingAnchor, constant: 10),
            
            burgerImageView.widthAnchor.constraint(equalToConstant: 24),
            burgerImageView.heightAnchor.constraint(equalToConstant: 24),
            burgerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 23),
            burgerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            wifiImageView.widthAnchor.constraint(equalToConstant: 120),
            wifiImageView.heightAnchor.constraint(equalToConstant: 120),
            wifiImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wifiImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            
            connectLabel.topAnchor.constraint(equalTo: wifiImageView.bottomAnchor, constant: 30),
            connectLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nowYearAndMonth.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nowYearAndMonth.topAnchor.constraint(equalTo: applogoImageView.bottomAnchor, constant: 48),
            
            tableContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableContainerView.topAnchor.constraint(equalTo: nowYearAndMonth.bottomAnchor, constant: 10),
            tableContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
            
            historyTableView.topAnchor.constraint(equalTo: tableContainerView.topAnchor),
            historyTableView.leadingAnchor.constraint(equalTo: tableContainerView.leadingAnchor),
            historyTableView.trailingAnchor.constraint(equalTo: tableContainerView.trailingAnchor),
            historyTableView.bottomAnchor.constraint(equalTo: tableContainerView.bottomAnchor),
            
            arrowleftImageView.widthAnchor.constraint(equalToConstant: 24),
            arrowleftImageView.heightAnchor.constraint(equalToConstant: 24),
            arrowleftImageView.topAnchor.constraint(equalTo: applogoImageView.bottomAnchor, constant: 60),
            arrowleftImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 75),
            
            arrowrightImageView.widthAnchor.constraint(equalToConstant: 24),
            arrowrightImageView.heightAnchor.constraint(equalToConstant: 24),
            arrowrightImageView.topAnchor.constraint(equalTo: applogoImageView.bottomAnchor, constant: 60),
            arrowrightImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -75),
            
            testBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -160),
            testBtn.widthAnchor.constraint(equalToConstant: 350),
            testBtn.heightAnchor.constraint(equalToConstant: 60),
            
            testBtn2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testBtn2.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            testBtn2.widthAnchor.constraint(equalToConstant: 350),
            testBtn2.heightAnchor.constraint(equalToConstant: 60),
            
            testBtn3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testBtn3.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            testBtn3.widthAnchor.constraint(equalToConstant: 350),
            testBtn3.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    @objc func testButtonTapped() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd[HH시mm분ss초]"
        let formattedDate = dateFormatter.string(from: currentDate)
        
        sendDataToServer()
        
        let context = CoreDataStack.shared.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context)!
        let logManagedObject = NSManagedObject(entity: entity, insertInto: context) as! Entity
        logManagedObject.savedTime = formattedDate
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: logEntries)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                logManagedObject.savedData = jsonString
            }
        } catch {
            print("Error converting array to JSON: \(error)")
        }
        
        do {
            try context.save()
            historyTableView.reloadData()
            print("Log entries saved to Core Data.")
        } catch {
            print("Error saving log entries: \(error)")
        }
        
    }
    
    @objc func testButton2Tapped() {
        let context = CoreDataStack.shared.viewContext
        do {
            coreDataEntries = try context.fetch(Entity.fetchRequest())
        } catch {
            print("Error fetching log entries: \(error)")
        }
        for logEntry in coreDataEntries {
            print("Formatted Timestamp: \(logEntry.savedTime)")
            print("Formatted JSON: \(logEntry.savedData)")
            print("==============================================")
        }
    }
    
    @objc func testButton3Tapped() {
        let context = CoreDataStack.shared.viewContext
        let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
        do {
            let logEntriesToDelete = try context.fetch(fetchRequest)
            for logEntry in logEntriesToDelete {
                context.delete(logEntry)
            }
            try context.save()
            coreDataEntries.removeAll()
            historyTableView.reloadData()
            print("All LogEntries deleted from Core Data.")
        } catch {
            print("Error deleting log entries: \(error)")
        }
    }
    
    func settingConnectView() {
        connectLabel.text = "ODB와\n연결되었습니다."
        iswifiImageAndLabelStatus = true
    }
    
    func settingCollectView() {
        iswifiImageAndLabelStatus = true
        
        wifiImageView.image = UIImage(named: "collection")
        connectLabel.text = "차량 데이터\n수집중 입니다."
        let connectLabelAttributedString = NSMutableAttributedString(string: connectLabel.text!)
        let color = UIColor(cgColor: CGColor(red: 50 / 255, green: 123 / 255, blue: 1, alpha: 1))
        let connectLabelRange = NSRange(location: 7, length: 3)
        connectLabelAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: connectLabelRange)
        connectLabel.attributedText = connectLabelAttributedString
    }
    
    func settingSaveView() {
        iswifiImageAndLabelStatus = true
        isListViewStatus = true
        
        wifiImageView.image = UIImage(named: "document")
        connectLabel.text = "차량 데이터\n저장중 입니다."
        let connectLabelAttributedString = NSMutableAttributedString(string: connectLabel.text!)
        let color = UIColor(cgColor: CGColor(red: 50 / 255, green: 123 / 255, blue: 1, alpha: 1))
        let connectLabelRange = NSRange(location: 7, length: 3)
        connectLabelAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: connectLabelRange)
        connectLabel.attributedText = connectLabelAttributedString
        
        // Send to server
        sendDataToServer()
        
        // save in coreData
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd[HH시mm분ss초]"
        let formattedDate = dateFormatter.string(from: currentDate)
        
        let context = CoreDataStack.shared.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context)!
        let logManagedObject = NSManagedObject(entity: entity, insertInto: context) as! Entity
        logManagedObject.savedTime = formattedDate
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: logEntries)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                logManagedObject.savedData = jsonString
            }
        } catch {
            print("Error converting array to JSON: \(error)")
        }
        
        do {
            try context.save()
            print("Log entries saved to Core Data.")
        } catch {
            print("Error saving log entries: \(error)")
        }
    }
    
    func settingResultView(_ nowDate: String) {
        iswifiImageAndLabelStatus = false
        
        applogoImageView.alpha = 0
        wifiImageView.alpha = 0
        connectLabel.alpha = 0
        burgerImageView.alpha = 0
        moveBackImageView.alpha = 1
        moveBackLabel.alpha = 1
        
        nowDateLabel.translatesAutoresizingMaskIntoConstraints = false
        nowDateLabel.text = nowDate
        nowDateLabel.font = UIFont(name: "Oswald-Regular", size: 20)
        nowDateLabel.textColor = .white
        
        resultImageView.translatesAutoresizingMaskIntoConstraints = false
        resultImageView.image = UIImage(named: "result")
        
//        dataSaveButton.addTarget(self, action: #selector(dataSaveButtonTapped) , for: .touchUpInside)
        
        let connectLabelAttributedString = NSMutableAttributedString(string: resultLabel.text!)
        let color = UIColor(cgColor: CGColor(red: 50 / 255, green: 123 / 255, blue: 1, alpha: 1))
        let connectLabelRange = NSRange(location: 0, length: 5)
        connectLabelAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: connectLabelRange)
        resultLabel.attributedText = connectLabelAttributedString
        
        let voltLabelStackView = UIStackView(arrangedSubviews: [voltImageView, voltLabel])
        voltLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        voltLabelStackView.axis = .horizontal
        voltLabelStackView.spacing = 5
        
        let voltStackView = UIStackView(arrangedSubviews: [voltLabelStackView, voltValue])
        voltStackView.translatesAutoresizingMaskIntoConstraints = false
        voltStackView.axis = .vertical
        voltStackView.alignment = .center
        voltStackView.spacing = 0
        
        let electricCurrentLabelStackView = UIStackView(arrangedSubviews: [electricCurrentImageView, electricCurrentLabel])
        electricCurrentLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        electricCurrentLabelStackView.axis = .horizontal
        electricCurrentLabelStackView.spacing = 5
        
        let electricCurrentStackView = UIStackView(arrangedSubviews: [electricCurrentLabelStackView, electricCurrentValue])
        electricCurrentStackView.translatesAutoresizingMaskIntoConstraints = false
        electricCurrentStackView.axis = .vertical
        electricCurrentStackView.alignment = .center
        electricCurrentStackView.spacing = 0
        
        let temperatureLabelStackView = UIStackView(arrangedSubviews: [temperatureImageView, temperatureLabel])
        temperatureLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabelStackView.axis = .horizontal
        temperatureLabelStackView.spacing = 5
        
        let temperatureStackView = UIStackView(arrangedSubviews: [temperatureLabelStackView, temperatureValue])
        temperatureStackView.translatesAutoresizingMaskIntoConstraints = false
        temperatureStackView.axis = .vertical
        temperatureStackView.alignment = .center
        temperatureStackView.spacing = 0
        
        resultStackView = UIStackView(arrangedSubviews: [voltStackView, borderImageView, electricCurrentStackView, borderImageView2, temperatureStackView])
        resultStackView.translatesAutoresizingMaskIntoConstraints = false
        resultStackView.axis = .horizontal
        resultStackView.spacing = 25
        
        view.addSubview(nowDateLabel)
        view.addSubview(resultImageView)
        view.addSubview(resultStackView)
        view.addSubview(resultLabel)
//        view.addSubview(dataSaveButton)
        NSLayoutConstraint.activate([
            nowDateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nowDateLabel.topAnchor.constraint(equalTo: applogoImageView.bottomAnchor, constant: 50),
            
            resultImageView.widthAnchor.constraint(equalToConstant: 180),
            resultImageView.heightAnchor.constraint(equalToConstant: 180),
            resultImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultImageView.topAnchor.constraint(equalTo: nowDateLabel.bottomAnchor, constant: 60),
            
            resultStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultStackView.topAnchor.constraint(equalTo: resultImageView.bottomAnchor, constant: 60),
            
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: resultStackView.bottomAnchor, constant: 30),
            
//            dataSaveButton.widthAnchor.constraint(equalToConstant: 310),
//            dataSaveButton.heightAnchor.constraint(equalToConstant: 60),
//            dataSaveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            dataSaveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
//    @objc func dataSaveButtonTapped() {
//        saveDataToFile(fileName: "\(currentDate)CarInfo.txt")
//    }
    
    @objc func didBurgerMenuTapped() {
        UIView.animate(withDuration: 0.3) {
            self.burgerMenuViewController?.view.frame.origin.x = 0
            self.wifiImageView.alpha = 0
            self.connectLabel.alpha = 0
            self.nowDateLabel.alpha = 0
            self.resultImageView.alpha = 0
            self.resultStackView.alpha = 0
            self.resultLabel.alpha = 0
//            self.dataSaveButton.alpha = 0
        }
    }
    
    @objc func didArrowLeftTapped() {
        iswifiImageAndLabelStatus = false
        isListViewStatus = true
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let currentDate = dateFormatter.date(from: nowYearAndMonth.text!) ?? Date()
        if let newDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) {
            nowYearAndMonth.text = dateFormatter.string(from: newDate)
            
            finalData = filteredData.filter { $0.contains(nowYearAndMonth.text ?? "") }
            historyTableView.reloadData()
        }
    }
    
    @objc func didArrowRightTapped() {
        iswifiImageAndLabelStatus = false
        isListViewStatus = true
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let currentDate = dateFormatter.date(from: nowYearAndMonth.text!) ?? Date()
        if let newDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate) {
            nowYearAndMonth.text = dateFormatter.string(from: newDate)
            finalData = filteredData.filter { $0.contains(nowYearAndMonth.text ?? "") }
            historyTableView.reloadData()
        }
    }
    
    @objc func didMoveBackTapped() {
        moveBackImageView.alpha = 0
        moveBackLabel.alpha = 0
        nowDateLabel.alpha = 0
        resultImageView.alpha = 0
        resultStackView.alpha = 0
        resultLabel.alpha = 0
//        dataSaveButton.alpha = 0
        burgerImageView.alpha = 1
        applogoImageView.alpha = 1
        arrowleftImageView.alpha = 1
        arrowrightImageView.alpha = 1
        nowYearAndMonth.alpha = 1
        tableContainerView.alpha = 1
    }
    
    @objc func sendPacket() {
        guard let characteristic = reqCharacteristic else {
            return
        }
        
        let packet = createPacket(seq: seq, obj: 0x00, mid: 0x01)
//        let logEntry = "SYS_CONNECT_REQ: [\([UInt8](packet))]"
//        logEntries.append(logEntry)
        
        seq += 1
        
        peripheral?.writeValue(packet, for: characteristic, type: .withResponse)
    }
    
    @objc func sendPacket2() {
        guard let characteristic = reqCharacteristic else {
            return
        }
        
        let packet = createPacket(seq: seq, obj: 0x00, mid: 0x09)
//        let logEntry = "SYS_VERSION2_REQ: [\([UInt8](packet))]"
//        logEntries.append(logEntry)
        
        seq += 1
        
        peripheral?.writeValue(packet, for: characteristic, type: .withResponse)
    }
    
    @objc func sendPacket3() {
        guard let characteristic = reqCharacteristic else {
            return
        }
        
        let packet = createPacket(seq: seq, obj: 0xA6, mid: 0x06)
//        let logEntry = "OBD_BP_VERSION_REQ: [\([UInt8](packet))]"
//        logEntries.append(logEntry)
        
        seq += 1
        
        peripheral?.writeValue(packet, for: characteristic, type: .withResponse)
    }
    
    @objc func sendPacket4() {
        guard let characteristic = reqCharacteristic else {
            return
        }
        
        let packet = createPacket(seq: seq, obj: 0xA6, mid: 0x03)
//        let logEntry = "OBD_CONFIG_REQ: [\([UInt8](packet))]"
//        logEntries.append(logEntry)
        
        seq += 1
        
        peripheral?.writeValue(packet, for: characteristic, type: .withResponse)
    }
    
    @objc func sendPacket5() {
        guard let characteristic = reqCharacteristic else {
            return
        }
        
        let packet = createPacket(seq: seq, obj: 0xA6, mid: 0x04)
//        let logEntry = "OBD_STATUS_REQ: [\([UInt8](packet))]"
//        logEntries.append(logEntry)
        
        seq += 1
        
        peripheral?.writeValue(packet, for: characteristic, type: .withResponse)
    }
    
    // Step 3: Create Packet with SOP, LEN, SDU, CRC, and EOP fields
    func createPacket(seq: UInt8, obj: UInt8, mid: UInt8) -> Data {
        // Construct your packet according to the format
        var packet = Data()
        let sdu = createSDU(seq: seq, obj: obj, mid: mid)
        
        packet.append(0xFE)  // SOP
        let lengthByte: UInt8 = UInt8(sdu.count)
        packet.append(lengthByte)  // LEN (length of SDU)
        packet.append(contentsOf: sdu)  // SDU
        packet.append(calculateCRC(data: sdu))  // CRC
        packet.append(0xFD)  // EOP
        
        return packet
    }
    
    // Step 4: Calculate CRC for SDU
    func calculateCRC(data: Data) -> UInt8 {
        let crcData = [UInt8](data)
        var crc: UInt8 = 0
        
        for byte in crcData {
            crc ^= byte
        }
        
        return crc
    }
    
    // Create SDU according to your message format
    func createSDU(seq: UInt8, obj: UInt8, mid: UInt8) -> Data {
        // Construct SDU with SEQ, OBJ, MID fields
        var sdu = Data()
        sdu.append(seq)   // SEQ
        sdu.append(obj)   // OBJ
        sdu.append(mid)   // MID (example)
        if mid == 0x01 {
            sdu.append(0xf0)  // SECRET
            sdu.append(0x01)  // AUTH
            sdu.append(0x00)  // ENC
            sdu.append(0x00)  // AUTO_MODE
        }
        if mid == 0x03 {
            
            sdu.append(0x00) // timeStamp
            sdu.append(0x00) // timeStamp
            sdu.append(0x00) // timeStamp
            sdu.append(0x00) // timeStamp
            
            for _ in 0...5 {
                sdu.append(0xFF) // filterA
                sdu.append(0xFF) // filterA
                sdu.append(0xFF) // filterA
                sdu.append(0xFF) // filterA
                
                sdu.append(0x00) // Sampling
                sdu.append(0x02) // Sampling
                
                sdu.append(0x00) // reporting
                sdu.append(0x01) // reporting
            }
            
        }
        return sdu
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.filter { $0.contains(nowYearAndMonth.text ?? "") }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dataString = filteredData[indexPath.row]
        let endIndex = dataString.index(dataString.startIndex, offsetBy: 21)
        extractedString = String(dataString[...endIndex])

        cell.textLabel?.text = extractedString
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        iswifiImageAndLabelStatus = false
        
        if indexPath.row == filteredData.count - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: cell.bounds.size.width)
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        }
        
//        let downloadImage = UIImageView()
//        downloadImage.image = UIImage(named: "download")
//        downloadImage.translatesAutoresizingMaskIntoConstraints = false
//        
//        let downloadImageTap = UITapGestureRecognizer(target: self, action: #selector(diddownloadImageTapped))
//        downloadImageTap.numberOfTapsRequired = 1
//        downloadImage.isUserInteractionEnabled = true
//        downloadImage.addGestureRecognizer(downloadImageTap)
//        
//        cell.contentView.addSubview(downloadImage)
//        NSLayoutConstraint.activate([
//            downloadImage.widthAnchor.constraint(equalToConstant: 20),
//            downloadImage.heightAnchor.constraint(equalToConstant: 20),
//            downloadImage.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
//            downloadImage.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -14),
//        ])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        arrowleftImageView.alpha = 0
        nowYearAndMonth.alpha = 0
        arrowrightImageView.alpha = 0
        tableContainerView.alpha = 0
        nowDateLabel.alpha = 1
        resultImageView.alpha = 1
        resultStackView.alpha = 1
        resultLabel.alpha = 1
//        dataSaveButton.alpha = 1
        self.settingResultView(extractedString)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
//    @objc func diddownloadImageTapped() {
//        print("데이터 다운로드")
//    }
}

extension ViewController: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            central.scanForPeripherals(withServices: [CBUUID(string: "FFF0")], options: nil)
        }
    }

    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi: NSNumber) {
        self.peripheral = peripheral
        
        central.connect(peripheral, options: nil)
        
//        if rssi.intValue > -50 {
//           
//        } else {
//            central.cancelPeripheralConnection(peripheral)
//            self.settingSaveView()
//        }
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        isConnected = true
        self.settingConnectView()
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        isConnected = false
        if let error = error {
            print("Bluetooth connection lost with error: \(error.localizedDescription)")
            self.settingSaveView()
        } else {
            print("Bluetooth connection lost")
            self.settingSaveView()
        }
    }
    
}

extension ViewController: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                peripheral.discoverCharacteristics([REQCharacteristicUUID, RSPCharacteristicUUID], for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                if characteristic.uuid == REQCharacteristicUUID {
                    reqCharacteristic = characteristic
                    packetTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(sendPacket), userInfo: nil, repeats: true)
                    packetTimer?.fire()
                    
                    packetTimer2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(sendPacket2), userInfo: nil, repeats: true)
                    packetTimer2?.fire()
                    
                    packetTimer3 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(sendPacket3), userInfo: nil, repeats: true)
                    packetTimer3?.fire()
                    
                    packetTimer4 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(sendPacket4), userInfo: nil, repeats: true)
                    packetTimer4?.fire()
                    
                    packetTimer5 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(sendPacket5), userInfo: nil, repeats: true)
                    packetTimer5?.fire()
                } else if characteristic.uuid == RSPCharacteristicUUID {
                    peripheral.setNotifyValue(true, for: characteristic)
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if error == nil {
            print("성공")
            print("RES IN didWriteValueFor: \(characteristic)")
            print("==========================================")
        } else {
            print("실패")
            print("Error: \(error!.localizedDescription)")
            print("==========================================")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if characteristic.uuid == RSPCharacteristicUUID {
            if let data = characteristic.value {
//                let currentDate = Date()
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//                let formattedDate = dateFormatter.string(from: currentDate)
                
                if [UInt8](data)[4] != 17 {
                    switch [UInt8](data)[4] {
                        // SYS_CONNECT_RSP(1)
                    case 1:
                        print("RES In UpdateValueFor(SYS_CONNECT_RSP): \([UInt8](data))")
                        print("==========================================")
                        //                        let logEntry = "SYS_CONNECT_RSP(1): [\([UInt8](data))]"
                        //                        logEntries.append(logEntry)
                        packetTimer?.invalidate()
                        packetTimer = nil
                        // SYS_VERSION2_RSP(9)
                    case 9:
                        print("RES In UpdateValueFor(SYS_VERSION2_RSP): \([UInt8](data))")
                        print("==========================================")
                        //                        let logEntry = "SYS_VERSION2_RSP(9): [\([UInt8](data))]"
                        //                        logEntries.append(logEntry)
                        packetTimer2?.invalidate()
                        packetTimer2 = nil
                        // OBD_BP_VERSION_RSP(6)
                    case 6:
                        print("RES In UpdateValueFor(OBD_BP_VERSION_RSP): \([UInt8](data))")
                        print("==========================================")
                        //                        let logEntry = "OBD_BP_VERSION_RSP(6): [\([UInt8](data))]"
                        //                        logEntries.append(logEntry)
                        packetTimer3?.invalidate()
                        packetTimer3 = nil
                        // OBD_CONFIG_RSP(3)
                    case 3:
                        print("RES In UpdateValueFor(OBD_CONFIG_RSP): \([UInt8](data))")
                        print("==========================================")
                        //                        let logEntry = "OBD_CONFIG_RSP(3): [\([UInt8](data))]"
                        //                        logEntries.append(logEntry)
                        packetTimer4?.invalidate()
                        packetTimer4 = nil
                        // OBD_STATUS_RSP(4)
                    case 4:
                        //                        let logEntry = "OBD_STATUS_RSP(4): [\([UInt8](data))]"
                        //                        logEntries.append(logEntry)
                        packetTimer5?.invalidate()
                        packetTimer5 = nil
                        self.settingCollectView()
                        print("모든값 보내기 성공")
                        print("RES In UpdateValueFor(OBD_STATUS_RSP): \([UInt8](data))")
                        print("==========================================")
                    case 22:
                        let currentDate = Date()
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let formattedDate = dateFormatter.string(from: currentDate)
                        // Combine the data array into a string for logging
                        let dataString = data.map { String(format: "%02X", $0) }.joined(separator: ", ")
                        let logEntry = "\(formattedDate): [\(dataString)]"
//                        print(logEntry)
                        logEntries.append(logEntry)
                    case 23:
                        let currentDate = Date()
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let formattedDate = dateFormatter.string(from: currentDate)
                        let dataString = data.map { String(format: "%02X", $0) }.joined(separator: ", ")
                        let logEntry = "\(formattedDate): [\(dataString)]"
//                        print(logEntry)
                        logEntries.append(logEntry)
                        if let values = parseBluetoothData2(data: [UInt8](data)) {
                            print(values)
                        }
                    case 24:
                        let currentDate = Date()
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let formattedDate = dateFormatter.string(from: currentDate)
                        let dataString = data.map { String(format: "%02X", $0) }.joined(separator: ", ")
                        let logEntry = "\(formattedDate): [\(dataString)]"
//                        print(logEntry)
                        logEntries.append(logEntry)
                        if let values = parseBluetoothData3(data: [UInt8](data)) {
                            var totalTemp: UInt8 = 0
                            for i in 0...values.MODULE_COUNT {
                                totalTemp = totalTemp + values.TEMP[Int(i)]
                            }
//                            var averageTemp = totalTemp / values.MODULE_COUNT
                        }
                    default:
                        packetTimer?.invalidate()
                        packetTimer = nil
                        packetTimer2?.invalidate()
                        packetTimer2 = nil
                        packetTimer3?.invalidate()
                        packetTimer3 = nil
                        packetTimer4?.invalidate()
                        packetTimer4 = nil
                        packetTimer5?.invalidate()
                        packetTimer5 = nil
                        let currentDate = Date()
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let formattedDate = dateFormatter.string(from: currentDate)
                        let dataString = data.map { String(format: "%02X", $0) }.joined(separator: ", ")
                        let logEntry = "\(formattedDate): [\(dataString)]"
//                        print(logEntry)
                        logEntries.append(logEntry)
                    }
                }
            }
        }
    }
    
    func sendDataToServer() {
        let jsonLogEntries = logEntries.map { entry in
            return #""\#(entry)""#
        }
        
        let jsonDataString = "[" + jsonLogEntries.joined(separator: ",") + "]"
        
        let requestData = ["data": jsonDataString]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestData, options: [])
            
            let url = URL(string: "https://vex-dev.lidro.com/api/v1/temp/data")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                if response.statusCode == 200 {
                    if let responseString = String(data: data, encoding: .utf8) {
                        print("Server response: \(responseString)")
                    }
                } else {
                    print("Error sending data: HTTP status code \(response.statusCode)")
                }
            }
            task.resume()
        } catch {
            print("Error converting logEntries to JSON data.")
        }
    }
    
//    func saveDataToFile(fileName: String) {
//        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//            let fileURL = documentsDirectory.appendingPathComponent(fileName)
//            do {
//                let logContent = logEntries.joined(separator: "\n")
//                try logContent.write(to: fileURL, atomically: true, encoding: .utf8)
//                print("Log saved to file: \(fileURL.path)")
//                let fileToShare = [fileURL]
//                let activityViewController = UIActivityViewController(activityItems: fileToShare, applicationActivities: nil)
//                if let popoverController = activityViewController.popoverPresentationController {
//                    popoverController.sourceView = self.view
//                    popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
//                    popoverController.permittedArrowDirections = []
//                }
//                self.present(activityViewController, animated: true, completion: nil)
//            } catch {
//                print("Error saving log to file: \(error.localizedDescription)")
//            }
//        }
//    }
}
