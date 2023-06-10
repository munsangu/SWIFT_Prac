import UIKit
import Network

class ViewController: UIViewController, NetServiceBrowserDelegate, StreamDelegate {
    let netServiceBrowser = NetServiceBrowser()
    var foundTVServices = [NetService]()
    var inputStream: InputStream?
    var outputStream: OutputStream?

    override func viewDidLoad() {
        super.viewDidLoad()
        netServiceBrowser.delegate = self
        netServiceBrowser.searchForServices(ofType: "_googlecast._tcp", inDomain: "local.")
    }

    // MARK: - NetServiceBrowserDelegate

    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        foundTVServices.append(service)

        if !moreComing {
            for tvService in foundTVServices {
                connectToTV(tvService)
                print("Found Android TV: \(tvService.name)")
            }
        }
    }
    
    func connectToTV(_ tvService: NetService) {
        var inputStream: InputStream?
        var outputStream: OutputStream?
        tvService.getInputStream(&inputStream, outputStream: &outputStream)
        
        guard let inputStream = inputStream, let outputStream = outputStream else {
            print("Failed to establish connection to the TV")
            return
        }
        
        self.inputStream = inputStream
        self.outputStream = outputStream
        
        inputStream.delegate = self
        outputStream.delegate = self
        
        inputStream.schedule(in: .current, forMode: .default)
        outputStream.schedule(in: .current, forMode: .default)
        
        inputStream.open()
        outputStream.open()
    }

    func netServiceBrowser(_ browser: NetServiceBrowser, didRemove service: NetService, moreComing: Bool) {
        if let index = foundTVServices.firstIndex(of: service) {
            foundTVServices.remove(at: index)
        }
    }
    
    func sendCommand(_ command: String) {
        guard let outputStream = outputStream else {
            print("No active output stream")
            return
        }
        
        let data = command.data(using: .utf8)!
        outputStream.write((data as NSData).bytes.bindMemory(to: UInt8.self, capacity: data.count), maxLength: data.count)
    }
    
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        if eventCode == .hasSpaceAvailable {
            // The output stream is ready for writing, you can send commands here
            sendCommand("power off")
        }
    }
    
    
}

