import UIKit
import MultipeerConnectivity

class ViewController: UIViewController {
    
    @IBOutlet weak var txfMessage: UITextField!
    @IBOutlet weak var txvChatList: UITextView!
    
    private var peers: [MCPeerID] = []
    private var chatList: [String] = [] {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                txvChatList.text = chatList.joined(separator: "\n")
            }
        }
    }
    
    private var session: MCSession!
    private var advertiser: MCNearbyServiceAdvertiser!
    // private var browser: MCNearbyServiceBrowser!
    private var browserVC: MCBrowserViewController!
    
    private let ChatServiceType = "Chat-service"
    private let localPeerID = MCPeerID(displayName: UIDevice.current.name)
    
    /// 내가 방장(host)인지 여부 판별
    private var isHosting = false
    
    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        session = MCSession(peer: localPeerID, securityIdentity: nil, encryptionPreference: .none)
        session.delegate = self
        
        advertiser = MCNearbyServiceAdvertiser(
            peer: localPeerID,
            discoveryInfo: nil,
            serviceType: ChatServiceType)
        
        advertiser.delegate = self
        
        txvChatList.text = chatList.joined(separator: "\n")
    }
    
    // MARK: - IBActions
    
    @IBAction func btnActShowBrowserVC(_ sender: Any) {
        browserVC = MCBrowserViewController(serviceType: ChatServiceType, session: session)
        browserVC.delegate = self
        present(browserVC, animated: true)
    }
    
    @IBAction func btnActStartAdvertising(_ sender: UISwitch) {
        if sender.isOn {
            advertiser.startAdvertisingPeer()
        } else {
            advertiser.stopAdvertisingPeer()
        }
    }
    
    @IBAction func btnActSendMessage(_ sender: UIButton) {
        do {
            if let text = txfMessage.text,
               let data = text.data(using: .utf8) {
                try session.send(
                    data,
                    toPeers: peers,
                    with: .reliable)
                txfMessage.text = ""
                chatList.append("Me: \(text)")
            }
        } catch {
            print("[Error] \(error)")
        }
    }
    
    @IBAction func btnActCameraOpen(_ sender: UIButton) {
 
        do {
            try session.send("open_camera".data(using: .utf8)!, toPeers: peers, with: .reliable)
        } catch {
            print("Failed to send command: \(error.localizedDescription)")
        }
        
    }
    
    
    // MARK: - Custom methods
    
    func sendHistory(to peer: MCPeerID) {
        // 1. Create the URL in your temporary directory.
        let tempFile = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent("messages.data")
        guard let historyData = try? JSONEncoder().encode(chatList) else { return }
        
        // 2. Write the chat history to a file at this URL.
        try? historyData.write(to: tempFile)
        
        // 3. Use MCSession to send a resource instead of Data.
        session?.sendResource(
            at: tempFile,
            withName: "Chat_History",
            toPeer: peer
        ) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func openCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
}

extension ViewController: MCNearbyServiceAdvertiserDelegate {
    // MARK: - MCNearbyServiceAdvertiserDelegate
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        let title = "Accept $\(peerID.displayName)'s Request"
        let message = "Would you like to accept from: \(peerID.displayName)"
        
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(
            title: "No",
            style: .cancel
        ) { _ in
            invitationHandler(false, nil)
        })
        
        alertController.addAction(UIAlertAction(
            title: "Yes",
            style: .default
        ) { _ in
            
            invitationHandler(true, self.session)
        })
        
        present(alertController, animated: true)
        isHosting = false
    }
}

extension ViewController: MCSessionDelegate {
    // MARK: - MCSessionDelegate
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            // peer 추가
            peers.append(peerID)
            
            // 채팅 히스토리 보냄
            if isHosting {
                sendHistory(to: peerID)
            }
            
        case MCSessionState.connecting:
            print("Connecting: \(peerID.displayName)")
        case MCSessionState.notConnected:
            print("Not Connected: \(peerID.displayName)")
        @unknown default:
            break
        }
    }
        
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print(#function, peerID, data)
        let message = String( data: data, encoding: .utf8) ?? ""
        chatList.append("\(peerID.displayName): \(message)")
        if let commandString = String(data: data, encoding: .utf8) {
            if commandString == "open_camera" {
                DispatchQueue.main.async {
                    self.openCamera()
                }
            }
        }
    }
        
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print(#function, peerID)
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print(#function, peerID)
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        guard let localURL = localURL,
              let data = try? Data(contentsOf: localURL),
              let chatList = try? JSONDecoder().decode([String].self, from: data) else {
            return
        }
        
        DispatchQueue.main.async {
            self.chatList.insert(contentsOf: chatList, at: 0)
        }

    }
}

extension ViewController: MCNearbyServiceBrowserDelegate {
    // MARK: - MCNearbyServiceBrowserDelegate
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        print(#function, peerID)
        
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print(#function, peerID)
    }
}

extension ViewController: MCBrowserViewControllerDelegate {
    // MARK: - MCBrowserViewControllerDelegate
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true)
        isHosting = true
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true)
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    
}

extension ViewController: UINavigationControllerDelegate {
    
}
