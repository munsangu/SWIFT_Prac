import SwiftUI
import WatchConnectivity

struct ContentView: View {
    @State private var deviceName = "No device connected"
        
    var body: some View {
        VStack {
            Text("Connected\n iOS Device Name:")
            Text(deviceName)
        }
        .onAppear {
            if WCSession.isSupported() {
                print("1")
                let session = WCSession.default
                if session.activationState == .activated {
                    if let message = session.receivedApplicationContext as? [String: Any],
                       let receivedDeviceName = message["deviceName"] as? String {
                        deviceName = receivedDeviceName
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
