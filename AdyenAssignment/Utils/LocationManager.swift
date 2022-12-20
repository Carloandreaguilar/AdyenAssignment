//
//  LocationManager.swift
//  AdyenAssignment
//
//  Created by Carlo André Aguilar on 19/12/22.
//

import CoreLocation
import Combine

class LocationManager: NSObject,  ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var location = PassthroughSubject<CLLocationCoordinate2D?, Never>()

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        case .denied:
            location.send(nil)
        default:
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        location.send(nil)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        default:
            return
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location.send(locations.first?.coordinate)
    }
}
