import AVFoundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var previewPicture: UIView!
    
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var reTakeButton: UIButton!
    @IBOutlet weak var takeAPhotoButton: UIButton!
    @IBOutlet weak var okPhotoButton: UIButton!
    @IBOutlet weak var changeCameraButton: UIButton!
    
    let takeAPhotoImageView = UIImageView()
    
    let closeButton = UIButton()
    let blackOverlayView = UIView()
    let checkImageView = UIImageView()
    let label1 = UILabel()
    let label2 = UILabel()
    let stackView1 = UIStackView()
    let stackView2 = UIStackView()
    let fhdImageView = UIImageView()
    let arrowImageView = UIImageView()
    let label3 = UILabel()
    let label4 = UILabel()
    let stackView3 = UIStackView()
    
    let captureSession = AVCaptureSession()
    var capturePhotoOutput: AVCapturePhotoOutput?
    var currentCamera: AVCaptureDevice? {
        return captureSession.inputs.compactMap { $0 as? AVCaptureDeviceInput }.first?.device
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkImageView.image = UIImage(named: "image (6)")
        checkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        label1.text = "정면 혹은 측면 상반신 촬영을"
        label1.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.textColor = .white
        
        label2.text = "권장합니다."
        label2.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.textColor = .white
        
        stackView1.addArrangedSubview(label1)
        stackView1.addArrangedSubview(label2)
        stackView1.axis = .vertical
        stackView1.alignment = .center
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        stackView1.spacing = 5
        
        stackView2.addArrangedSubview(checkImageView)
        stackView2.addArrangedSubview(stackView1)
        stackView2.axis = .vertical
        stackView2.alignment = .center
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        stackView2.spacing = 20
        
        fhdImageView.image = UIImage(named: "image (5)")
        fhdImageView.translatesAutoresizingMaskIntoConstraints = false
        fhdImageView.contentMode = .scaleAspectFill
        
        arrowImageView.image = UIImage(named: "image (7)")
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.contentMode = .scaleAspectFill
        
        label3.text = "또는 사진을 가져와서도"
        label3.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.textColor = .white
        
        label4.text = "측정이 가능합니다."
        label4.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.textColor = .white
        
        stackView3.addArrangedSubview(label3)
        stackView3.addArrangedSubview(label4)
        stackView3.axis = .vertical
        stackView3.alignment = .fill
        stackView3.translatesAutoresizingMaskIntoConstraints = false
        stackView3.spacing = 5
        
        view.addSubview(blackOverlayView)
        blackOverlayView.addSubview(closeButton)
        blackOverlayView.addSubview(stackView2)
        blackOverlayView.addSubview(fhdImageView)
        blackOverlayView.addSubview(arrowImageView)
        blackOverlayView.addSubview(stackView3)
        
        blackOverlayView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        blackOverlayView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blackOverlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blackOverlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blackOverlayView.topAnchor.constraint(equalTo: view.topAnchor),
            blackOverlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        closeButton.setImage(UIImage(named: "image (8)"), for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: blackOverlayView.topAnchor, constant: 50),
            closeButton.trailingAnchor.constraint(equalTo: blackOverlayView.trailingAnchor, constant: -20),
            stackView2.topAnchor.constraint(equalTo: blackOverlayView.topAnchor, constant: 80),
            stackView2.leadingAnchor.constraint(equalTo: blackOverlayView.leadingAnchor, constant: 20),
            stackView2.trailingAnchor.constraint(equalTo: blackOverlayView.trailingAnchor, constant: -20),
            fhdImageView.centerXAnchor.constraint(equalTo: blackOverlayView.centerXAnchor),
            fhdImageView.centerYAnchor.constraint(equalTo: blackOverlayView.centerYAnchor),
            fhdImageView.leadingAnchor.constraint(equalTo: blackOverlayView.leadingAnchor, constant: 0),
            fhdImageView.trailingAnchor.constraint(equalTo: blackOverlayView.trailingAnchor, constant: 0),
            arrowImageView.bottomAnchor.constraint(equalTo: blackOverlayView.bottomAnchor, constant: -150),
            arrowImageView.leadingAnchor.constraint(equalTo: blackOverlayView.leadingAnchor, constant: 50),
            stackView3.leadingAnchor.constraint(equalTo: blackOverlayView.leadingAnchor, constant: 100),
            stackView3.bottomAnchor.constraint(equalTo: blackOverlayView.bottomAnchor, constant: -150),
        ])
        
        blackOverlayView.isHidden = false
        closeButton.isHidden = false
        stackView2.isHidden = false
        fhdImageView.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setupCameraPreview()
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.captureSession.stopRunning()
    }
    
    @objc func closeButtonTapped() {
        blackOverlayView.isHidden = true
        closeButton.isHidden = true
        stackView2.isHidden = true
        fhdImageView.isHidden = true
    }
    
    func setupCameraPreview() {
        captureSession.sessionPreset = .photo
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            print("카메라에 접근할 수 없습니다.")
            return
        }
        
        do {
            let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            captureSession.addInput(videoInput)
            
            let capturePhotoOutput = AVCapturePhotoOutput()
            if captureSession.canAddOutput(capturePhotoOutput) {
                captureSession.addOutput(capturePhotoOutput)
                self.capturePhotoOutput = capturePhotoOutput
            }
            
            let captureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            captureVideoPreviewLayer.videoGravity = .resizeAspectFill
            captureVideoPreviewLayer.frame = previewPicture.bounds
            previewPicture.layer.addSublayer(captureVideoPreviewLayer)
            
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
            }
        } catch {
            print("카메라 설정 중 오류 발생: \(error.localizedDescription)")
        }
    }
    
    @IBAction func openGalleryButtonTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true)
    }
    
    @IBAction func reTakeButtonTapped(_ sender: UIButton) {
        galleryButton.alpha = 1
        takeAPhotoButton.alpha = 1
        changeCameraButton.alpha = 1
        reTakeButton.alpha = 0
        okPhotoButton.alpha = 0
        
        takeAPhotoImageView.image = nil
    }
    
    @IBAction func okPhotoButtonTapped(_ sender: UIButton) {
        print("Okay, Next!")
    }
    
    @IBAction func takeAPhotoButtonTapped(_ sender: UIButton) {
        galleryButton.alpha = 0
        takeAPhotoButton.alpha = 0
        changeCameraButton.alpha = 0
        reTakeButton.alpha = 1
        okPhotoButton.alpha = 1
        
        guard captureSession.isRunning, let capturePhotoOutput = capturePhotoOutput else {
            print("Capture session is not ready.")
            return
        }
        
        let photoSettings = AVCapturePhotoSettings()
        capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
    
    @IBAction func changeCameraButtonTapped(_ sender: UIButton) {

        guard let currentCamera = currentCamera else { return }
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if authorizationStatus == .denied || authorizationStatus == .restricted {
            print("Camera access denied or restricted.")
            return
        }
        
        captureSession.beginConfiguration()
        
        guard let currentInput = captureSession.inputs.first as? AVCaptureDeviceInput else { return }
        captureSession.removeInput(currentInput)
        
        let newCamera: AVCaptureDevice?
        if currentCamera.position == .back {
            newCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
        } else {
            newCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        }
        
        do {
            if let newCamera = newCamera {
                let newInput = try AVCaptureDeviceInput(device: newCamera)
                captureSession.addInput(newInput)
            }
        } catch {
            print("Camera switch error: \(error.localizedDescription)")
        }
        
        captureSession.commitConfiguration()
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            takeAPhotoImageView.image = selectedImage
            takeAPhotoImageView.contentMode = .scaleAspectFill
            takeAPhotoImageView.frame = previewPicture.bounds
            takeAPhotoImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            previewPicture.addSubview(takeAPhotoImageView)
            
            galleryButton.alpha = 0
            takeAPhotoButton.alpha = 0
            changeCameraButton.alpha = 0
            reTakeButton.alpha = 1
            okPhotoButton.alpha = 1
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error.localizedDescription)")
            return
        }
        
        if let imageData = photo.fileDataRepresentation(), let capturedImage = UIImage(data: imageData) {
            DispatchQueue.main.async {
                self.takeAPhotoImageView.image = capturedImage
                self.takeAPhotoImageView.contentMode = .scaleAspectFill
                self.takeAPhotoImageView.frame = self.previewPicture.bounds
                self.takeAPhotoImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                self.previewPicture.addSubview(self.takeAPhotoImageView)
            }
        }
    }
}
