import UIKit
import CoreBluetooth

class HRMViewController: UIViewController {
  
  @IBOutlet weak var heartRateLabel: UILabel!
  @IBOutlet weak var bodySensorLocationLabel: UILabel!
  var centralManager: CBCentralManager!
  var heartRatePeripheral: CBPeripheral!

  let batteryLevelCharacteristicCBUUID = CBUUID(string: "0x2A19")
  let localTimeInformationCharacteristicCBUUID = CBUUID(string: "0x2A0F")
  let modelNumberStringCharacteristicCBUUID = CBUUID(string: "0x2A24")
  let manufacturerNameStringCharacteristicCBUUID = CBUUID(string: "0x2A29")
  let timeZoneCharacteristicCBUUID = CBUUID(string: "0x2A0E")
  let dstOffsetCharacteristicCBUUID = CBUUID(string: "0x2A0D")

  override func viewDidLoad() {
    super.viewDidLoad()
    
    heartRateLabel.font = UIFont.monospacedDigitSystemFont(ofSize: heartRateLabel.font!.pointSize, weight: .regular)
    
    centralManager = CBCentralManager(delegate: self, queue: nil)
  }
  
  func onHeartRateReceived(_ heartRate: Int) {
    heartRateLabel.text = String(heartRate)
    print("BPM: \(heartRate)")
  }
}

extension HRMViewController: CBCentralManagerDelegate {
  
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    
    switch central.state {
    case .unknown:
      print("central.state is .unknown")
    case .resetting:
      print("central.state is .resetting")
    case .unsupported:
      print("central.state is .unsupported")
    case .unauthorized:
      print("central.state is .unauthorized")
    case .poweredOff:
      print("central.state is .poweredOff")
    case .poweredOn:
      print("central.state is .poweredOn")
      centralManager.scanForPeripherals(withServices: nil)
    }
    
  }
  
  func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
    
    if peripheral.name != nil {
      print(peripheral)
    }
  
    heartRatePeripheral = peripheral
    heartRatePeripheral.delegate = self
    
//    if peripheral.name == "QCY-T5" {
//      central.connect(heartRatePeripheral)
//      central.stopScan()
//    }

  }
  
  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    
    print("\(peripheral.name ?? "Unknown device") connected!")
    heartRatePeripheral.discoverServices(nil)
    
  }
  
}

extension HRMViewController: CBPeripheralDelegate {
  
  func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
    
    guard let services = peripheral.services else { return }
    
    for service in services {
      print(service)
      peripheral.discoverCharacteristics(nil, for: service)
    }
    
  }
  
  func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
    guard let characteristics = service.characteristics else { return }
    
    for characteristic in characteristics {
      if characteristic.properties.contains(.read) {
        print("\(characteristic.uuid): properties contains .read")
        peripheral.readValue(for: characteristic)
      } else if characteristic.properties.contains(.notify) {
        print("\(characteristic.uuid): properties contains .notify")
        peripheral.setNotifyValue(true, for: characteristic)
      } else {
        print("\(characteristic.uuid): properties not contains")
      }
    }
    
  }

  
  func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {

    switch characteristic.uuid {
      
    case batteryLevelCharacteristicCBUUID:
      guard let characteristicData = characteristic.value, let byte = characteristicData.first else { return }
      heartRateLabel.text = "\(String(byte))%"
      
    case localTimeInformationCharacteristicCBUUID:
      guard let characteristicData = characteristic.value else { return }
      if let localTime = getCurrentLocalTime(parseTimeZone(characteristicData)) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        let formattedLocalTime = dateFormatter.string(from: localTime)
        print(formattedLocalTime)
      }
      
    case manufacturerNameStringCharacteristicCBUUID:
      guard let characteristicData = characteristic.value else { return }
      if let byte = String(data: characteristicData, encoding: .utf8) {
        bodySensorLocationLabel.text = "\(String(byte))"
      }
      
    case modelNumberStringCharacteristicCBUUID:
      guard let characteristicData = characteristic.value else { return }
      if let byte = String(data: characteristicData, encoding: .utf8) {
        print(byte)
      }
      
    default:
      print("Unhandled Characteristic UUID: \(characteristic.uuid)")
    }
    
  }
  
  func parseTimeZone(_ data: Data) -> Int {
    guard let value = data.first else {
        return 0
    }
    
    if value == 0x80 {
        return -1 // 시간대 오프셋이 알려지지 않음
    }
    
    let offset = Int(Int8(bitPattern: value)) * 15
    return offset
  }
  
  func getCurrentLocalTime(_ timeZoneOffset: Int) -> Date? {
    let currentTime = Date()
    let timeZoneSeconds = timeZoneOffset
    let timeZone = TimeZone(secondsFromGMT: timeZoneSeconds)
    let localTime = currentTime.addingTimeInterval(TimeInterval(timeZoneSeconds))
    return localTime
  }
  
}
