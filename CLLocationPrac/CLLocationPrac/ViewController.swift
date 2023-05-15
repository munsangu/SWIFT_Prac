import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var userLocation: UILabel!
    let locationManager = CLLocationManager()
    var previousCoordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // location Setting
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        // mapView Setting
        mapView.mapType = MKMapType.standard
        mapView.setUserTrackingMode(.follow, animated: true)
        mapView.delegate = self
        mapView.showsUserLocation = true
        let zoomLevel: Double = 14
        let camera = mapView.camera
        camera.altitude = pow(2, (20 - zoomLevel)) * MKMetersPerMapPointAtLatitude(mapView.centerCoordinate.latitude)
        mapView.setCamera(camera, animated: true)
        
        
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {return}
        let latitude = location.coordinate.latitude
        let longtitude = location.coordinate.longitude
        
        userLocation.text = "LAT: \(latitude), LNG: \(longtitude)"
        
        if let previousCoordinate = self.previousCoordinate {
            var points: [CLLocationCoordinate2D] = []
            let point1 = CLLocationCoordinate2DMake(previousCoordinate.latitude, previousCoordinate.longitude)
            let point2: CLLocationCoordinate2D
            = CLLocationCoordinate2DMake(latitude, longtitude)
            points.append(point1)
            points.append(point2)
            let lineDraw = MKPolyline(coordinates: points, count:points.count)
            self.mapView.addOverlay(lineDraw)
        }
        
        self.previousCoordinate = location.coordinate
    }
    
    
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        guard let polyLine = overlay as? MKPolyline else {
            print("can't draw polyline")
            return MKOverlayRenderer()
        }
        let renderer = MKPolylineRenderer(polyline: polyLine)
        return renderer
        
    }
    
}
