import SwiftUI
import WatchConnectivity
import UserNotifications

struct ContentView: View {
//    @StateObject var counter = Counter()
    @StateObject var manager = NotificationManager()
    @State var isView = false
    
    var body: some View {
        if !isView {
            VStack {
                Spacer()

                VStack {
                    Button(action: { sendCommandToRobot("Go straight") }) {
                        Image(systemName: "arrowtriangle.up.fill")
                    }
                    .padding()
                    .frame(width: 80.0, height: 80.0)
                    .font(.title)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(80)

                    HStack {
                        Button(action: { sendCommandToRobot("Turn left") }) {
                            Image(systemName: "arrowtriangle.backward.fill")
                        }
                        .padding()
                        .frame(width: 80.0, height: 80.0)
                        .font(.title)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(80)

                        Button(action: { sendCommandToRobot("Power ON / OFF") } ) {
                            Image(systemName: "power")
                        }
                        .padding()
                        .frame(width: 80.0, height: 80.0)
                        .font(.title)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(80)

                        Button(action: { sendCommandToRobot("Turn right") }) {
                            Image(systemName: "arrowtriangle.right.fill")
                        }
                        .padding()
                        .frame(width: 80.0, height: 80.0)
                        .font(.title)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(80)

                    }

                    Button(action: { sendCommandToRobot("Go back") }) {
                        Image(systemName: "arrowtriangle.down.fill")
                    }
                    .padding()
                    .frame(width: 80.0, height: 80.0)
                    .font(.title)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(80)
                }
                .padding()

                Spacer()

                VStack {
                    
                    Spacer()
                    
                    Button(action: manager.scheduleNotification) {
                        Image(systemName: "bell")
                    }
                    .padding()
                    .frame(width: 80.0, height: 80.0)
                    .font(.title)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(80)
                    
                    Spacer()
                    
                    Button(action: {print("Fake")}) {
                        Image(systemName: "arrowshape.turn.up.right.fill")
                    }
                    .padding()
                    .frame(width: 80.0, height: 80.0)
                    .font(.title)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(80)
                    
                    Spacer()
                    
                    Button(action: {sendCommandToRobot("Open Camera")}) {
                        Image(systemName: "camera.fill")
                    }
                    .padding()
                    .frame(width: 80.0, height: 80.0)
                    .font(.title)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(80)
                    
                    Spacer()

                }
                Spacer()
            }
            .background(Color.gray)
            .padding()
            .onAppear {
                if WCSession.default.isReachable {
                    print("2")
                    let deviceName = UIDevice.current.name
                    let message = ["deviceName": deviceName]
                    WCSession.default.sendMessage(message, replyHandler: nil) { error in
                        print("Error sending device name to watch: \(error.localizedDescription)")
                    }
                }
            }
        } else {
            Text("1234")
        }
    }
        
    private func sendCommandToRobot(_ command: String) {
        print(command)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
