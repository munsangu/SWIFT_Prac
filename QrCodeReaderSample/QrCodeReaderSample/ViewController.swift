//
//  ViewController.swift
//  QrCodeReaderSample
//
//  Created by 문상우 on 2023/06/12.
//

import UIKit
import AVFoundation
import QRCodeReader

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    let resultLabel = UILabel()
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            $0.showTorchButton = false
            $0.showSwitchCameraButton = true
            $0.showCancelButton = true
            $0.showOverlayView = true
            $0.rectOfInterest = CGRect(x: 0.2, y: 0.3, width: 0.6, height: 0.3)
        }
        return QRCodeReaderViewController(builder: builder)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func checkCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { grant in
            if !grant {
                DispatchQueue.main.async {
                    var alert = UIAlertController(title: "Camera Access Denied Status", message: "Don't have permission to access the camera.", preferredStyle: .alert)
                    let titleAttributes: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
                    let titleString = NSAttributedString(string: "Camera Access Denied Status", attributes: titleAttributes)
                    alert.setValue(titleString, forKey: "attributedTitle")
                    let messageAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 11)]
                    let messageString = NSAttributedString(string: "Don't have permission to access the camera.", attributes: messageAttributes)
                    alert.setValue(messageString, forKey: "attributedMessage")
                    let okayAction = UIAlertAction(title: "Setting", style: .default) { _ in
                        if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(appSetting)
                        }
                    }
                    let noAction = UIAlertAction(title: "Close", style: .default) { action in return }
                    alert.addAction(noAction)
                    alert.addAction(okayAction)
                    self.present(alert, animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    self.QRCodeScannerOpen()
                }
            }
        }
    }
    
    private func QRCodeScannerOpen() {
        resultLabel.text = ""
        resultLabel.font = UIFont.systemFont(ofSize: 20)
        resultLabel.textAlignment = .center
        resultLabel.backgroundColor = .clear
        resultLabel.frame = CGRect(origin: self.labelPosition(forSize: CGSize(width: 200, height: 50), inView: readerVC.view), size: CGSize(width: 200, height: 50))
        readerVC.delegate = self
        readerVC.view.addSubview(resultLabel)
        readerVC.modalPresentationStyle = .overFullScreen
        present(readerVC, animated: true, completion: nil)
    }
    
    private func labelPosition(forSize size: CGSize, inView view: UIView) -> CGPoint {
        let x = (view.bounds.width - size.width) / 2
        let y = (view.bounds.height - size.height) / 1.5
        return CGPoint(x: x, y: y)
    }
    
    private func playsound() {
        guard let url = Bundle.main.url(forResource: "success_sound", withExtension: ".mp3") else {
            print("Could not find success sound file")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            player?.play()
        } catch {
            print("Could not play success sound: \(error.localizedDescription)")
        }
    }
    
}

extension ViewController: QRCodeReaderViewControllerDelegate {
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        self.resultLabel.backgroundColor = .green
        self.resultLabel.font = .boldSystemFont(ofSize: 10.0)
        self.resultLabel.text = "\(result.value)"
        UIView.animate(withDuration: 1, animations: {
            self.resultLabel.alpha = 0
        }, completion: { _ in
            self.resultLabel.alpha = 1
            self.resultLabel.text = ""
            self.resultLabel.backgroundColor = .clear
            reader.startScanning()
        })
        self.playsound()
        reader.stopScanning()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.dismiss(animated: true)
        }
    }
    
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        let cameraName = String(newCaptureDevice.device.localizedName)
        print("cameraName: \(cameraName)")
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        self.dismiss(animated: true)
    }
    
}
