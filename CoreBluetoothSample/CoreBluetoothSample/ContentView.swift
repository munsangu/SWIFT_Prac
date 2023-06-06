import SwiftUI
import CoreBluetooth

class BluetoothViewModel: NSObject, ObservableObject, CBPeripheralDelegate {
    
    private var centralManager: CBCentralManager?
    var peripherals: [CBPeripheral] = []
    @Published var peripheralNames: [String] = []
    private var connectedPeripheral: CBPeripheral?
    private var characteristic: CBCharacteristic?
    
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
        guard let peripheral = connectedPeripheral,
              let characteristic = self.characteristic else {
            return
        }
        
        let message = "1234"
        guard let data = message.data(using: .utf8) else {
            return
        }
        
        peripheral.writeValue(data, for: characteristic, type: .withResponse)
    }
}

extension BluetoothViewModel: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            self.centralManager?.scanForPeripherals(withServices: nil)
        }
    }
    
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
            if characteristic.properties.contains(.write) {
                self.characteristic = characteristic
            }
            
            if characteristic.properties.contains(.notify) {
                peripheral.setNotifyValue(true, for: characteristic)
            }
            
            peripheral.readValue(for: characteristic)
            print("Characteristics: \(characteristic)")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let value = characteristic.value,
           let receivedMessage = String(data: value, encoding: .utf8) {
            print("Updated value: \(value)")
            print("Received Message: \(receivedMessage)")
        }
    }
}

struct ContentView: View {
    
    @ObservedObject private var bluetoothViewModel = BluetoothViewModel()
    @State private var selectedPeripheral: CBPeripheral?
    @State private var successMessage = ""
    @State private var isDeviceConnected = false
    
    var body: some View {
        NavigationView {
            VStack {
                List(bluetoothViewModel.peripheralNames, id: \.self) { peripheral in
                    Button(action: {
                        guard let selectedPeripheral = bluetoothViewModel.peripherals.first(where: { $0.name == peripheral }) else { return }
                        self.selectedPeripheral = selectedPeripheral
                        bluetoothViewModel.connect(to: selectedPeripheral)
                        bluetoothViewModel.sendMessage()
                        successMessage = "Message sent successfully"
                        isDeviceConnected = true
                    }) {
                        Text(peripheral)
                    }
                    .foregroundColor(.black)
                }
                
                if let connectedPeripheral = selectedPeripheral, isDeviceConnected {
                    Text("Connected Device: \(connectedPeripheral.name!)")
                        .font(.headline)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            // Handle up button action
                        }) {
                            Image(systemName: "arrow.up")
                        }
                        .padding()
                        
                        Spacer()
                        
                        Button(action: {
                            // Handle down button action
                        }) {
                            Image(systemName: "arrow.down")
                        }
                        .padding()
                        
                        Spacer()
                        
                        Button(action: {
                            // Handle left button action
                        }) {
                            Image(systemName: "arrow.left")
                        }
                        .padding()
                        
                        Spacer()
                        
                        Button(action: {
                            // Handle right button action
                        }) {
                            Image(systemName: "arrow.right")
                        }
                        .padding()
                        
                        Spacer()
                    }
                    .foregroundColor(.black)
                }
                
                Text(successMessage)
                    .foregroundColor(.green)
            }
            .navigationTitle("Peripherals")
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
