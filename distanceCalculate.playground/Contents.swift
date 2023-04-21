import UIKit
import CoreLocation

func distanceCalculator(preLat: Double?, preLng: Double?, postLat: Double?, postLng: Double?) -> Double {
    guard let preLat = preLat, let preLng = preLng, let postLat = postLat, let postLng = postLng else {
        return 0.0
    }
    let preLocation = CLLocation(latitude: preLat, longitude: preLng)
    let postLocation = CLLocation(latitude: postLat, longitude: postLng)
    let distanceInMeters = preLocation.distance(from: postLocation)
    return Double(distanceInMeters.rounded(.toNearestOrAwayFromZero))
}

let res = distanceCalculator(preLat: 37.55866110788012, preLng: 126.80310395213151, postLat: 37.49322300, postLng: 126.92446120)
print("RESULT is \(res/1000)km")
