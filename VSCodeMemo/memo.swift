import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    
    var centralManager: CBCentralManager!
    var connectPeripheral: CBPeripheral!
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    var connectionTimer: Timer?
    
    @IBOutlet weak var connectedDeivce: UILabel!
    @IBOutlet weak var conectionStatus: UILabel!
    @IBOutlet weak var batterLevelLabel: UILabel!
    @IBOutlet weak var pnpIDLabel: UILabel!
    
    let batteryLevelChracteristicCBUUID = CBUUID(string: "0x2A19")
    let pnpIDChracteristicCBUUID = CBUUID(string: "0x2A50")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
}

extension ViewController: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("Central status is .poweredOn")
            centralManager.scanForPeripherals(withServices: nil)
        case .poweredOff:
            print("Central status is .poweredOff")
        case .unauthorized:
            print("Central status is .unauthorized")
        case .unknown:
            print("Central status is .unknown")
        case .resetting:
            print("Central status is .resetting")
        case .unsupported:
            print("Central status is .unsupported")
        @unknown default:
            fatalError("What happend?")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if peripheral.name != nil {
            print(peripheral)
        }
        
        connectPeripheral = peripheral
        connectPeripheral.delegate = self
        
        if peripheral.name == "Smart Tank 510 series" {
            central.connect(connectPeripheral)
            central.stopScan()
        }
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        let stringWithoutWhitespace = peripheral.name?.replacingOccurrences(of: "       ", with: "")
        connectedDeivce.text = "\(stringWithoutWhitespace ?? "unknown Device")"
        connectPeripheral.discoverServices(nil)
        
        beginBackgroundTask()
        DispatchQueue.main.async {
            self.connectionTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.checkConnectionStatus), userInfo: nil, repeats: true)
            RunLoop.current.add(self.connectionTimer!, forMode: .default)
        }
    }
    
    func beginBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask(withName: "BackgroudTask")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1000.0) {
            self.endBackgroundTask()
        }
    }

    func endBackgroundTask() {
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }
        
    @objc func checkConnectionStatus() {
        if connectPeripheral.state == .connected {
            conectionStatus.text = "connect"
            self.sendTokenToServer()
        } else {
            conectionStatus.text = "disconnect"
            connectedDeivce.text = "Nothing"
            batterLevelLabel.text = "Nothing"
            pnpIDLabel.text = "Nothing"
        }
    }
    
}

extension ViewController: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        
        for service in services {
            print(service)
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let chracteristics = service.characteristics else { return }
        
        for chracteristic in chracteristics {
            if chracteristic.properties.contains(.read) {
                print("\(chracteristic.uuid): properties contains .read")
                peripheral.readValue(for: chracteristic)
            } else if chracteristic.properties.contains(.notify) {
                print("\(chracteristic.uuid): properties contains .notify")
                peripheral.setNotifyValue(true, for: chracteristic)
            } else {
                print("\(chracteristic.uuid): properties not contains")
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        switch characteristic.uuid {
        case batteryLevelChracteristicCBUUID:
            guard let characteristicData = characteristic.value, let byte = characteristicData.first else { return }
            batterLevelLabel.text = "\(String(byte))%"
        case pnpIDChracteristicCBUUID:
            guard let characteristicData = characteristic.value, let byte = characteristicData.first else { return }
            pnpIDLabel.text = "\(String(byte))"
        default:
            print("Unhandled Characteristic UUID: \(characteristic.uuid)")
        }
    }
    
}