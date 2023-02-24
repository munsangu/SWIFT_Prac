// 백그라운드 상태에서도 위치를 추적하는 코드(위도 / 경도) - 추후 카카오맵 또는 유사 맵에서 표시할 경우 위도 / 경도를 주소로 변환해야함

import UIKit
import CoreLocation

class ViewController: UIViewController {

    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        requestLocationAuthorization()
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.startUpdatingLocation()
    }
    
    private func requestLocationAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }
}

extension ViewController: CLLocationManagerDelegate {
        
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatusSwitch(with: manager)
        locationManager.startUpdatingHeading()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("didupdate \(location.coordinate.latitude) \(location.coordinate.longitude)")
        }
    }
    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Error \(error.localizedDescription)")
//    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // 14.0부터
        locationStatusSwitch(with: manager)
    }
    
    func locationStatusSwitch(with locationManager: CLLocationManager) {
        var status: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus
        } else {
            // Fallback on earlier versions
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            break
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            print(".authorizedAlways, .authorizedWhenInUse")
        case .authorized:
            break
        @unknown default:
            break
        }
    }
}
