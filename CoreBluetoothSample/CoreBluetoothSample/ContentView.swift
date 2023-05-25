import SwiftUI
import CoreBluetooth

class BluetoothViewModel: NSObject, ObservableObject, CBPeripheralDelegate {
    
    private var centralManager: CBCentralManager?
    var peripherals: [CBPeripheral] = []
    @Published var peripheralNames: [String] = []
    private var connectedPeripheral: CBPeripheral?
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
    }
    
    func connect(to peripheral: CBPeripheral) {
        self.connectedPeripheral = peripheral
        self.connectedPeripheral?.delegate = self
        self.centralManager?.connect(peripheral)
    }
    
    func sendMessage() {
        guard let peripheral = connectedPeripheral else { return }
        
        let message = "1234"
        guard let characteristic = peripheral.services?.first?.characteristics?.first(where: { $0.properties.contains(.write) }) else { return }
        
        peripheral.writeValue(message.data(using: .utf8)!, for: characteristic, type: .withResponse)
    }
    
}

extension BluetoothViewModel: CBCentralManagerDelegate {
    
    // central 기기의 블루투스가 켜져있는지, 꺼져있는지 확인합니다. 확인하여 centralManager.state의 값을 .powerOn 또는 .powerOff로 변경합니다.
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            self.centralManager?.scanForPeripherals(withServices: nil)
        }
    }
    
    // service 검색에 성공 시 호출되는 메서드입니다.
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !peripherals.contains(peripheral) {
            self.peripherals.append(peripheral)
            if let peripheralName = peripheral.name {
                self.peripheralNames.append(peripheralName)
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to \(peripheral.name ?? "Unknown Peripheral")")
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        
        if let characteristic = peripheral.services?.first?.characteristics?.first(where: { $0.properties.contains(.notify) }) {
            peripheral.setNotifyValue(true, for: characteristic)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
            print("Service: \(service)")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics {
            peripheral.readValue(for: characteristic)
            print("Characteristics: \(characteristic)")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let value = characteristic.value {
            print("Updated value: \(value)")
            
            if let receivcedMessage = String(data: value, encoding: .utf8) {
                print("Received Message: \(receivcedMessage)")
            }
        }
    }
}

struct ContentView: View {
    
    @ObservedObject private var bluetoothViewModel = BluetoothViewModel()
    @State private var selectedPeripheral: CBPeripheral?
    @State private var successMessage = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List(bluetoothViewModel.peripheralNames, id: \.self) { peripheral in
                    Button {
                        guard let selectedPeripheral = bluetoothViewModel.peripherals.first(where: { $0.name == peripheral }) else { return }
                        self.selectedPeripheral = selectedPeripheral
                        bluetoothViewModel.connect(to: selectedPeripheral)
                        bluetoothViewModel.sendMessage()
                        successMessage = "메세지를 성공적으로 발송했습니다"
                    } label: {
                        Text(peripheral)
                    }
                    .foregroundColor(.black)
                }
                Text(successMessage)
                    .foregroundColor(.green)
            }
            .navigationTitle("주변 기기")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
