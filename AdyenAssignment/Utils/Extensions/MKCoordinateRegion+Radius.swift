//
//  MKCoordinateRegion+Radius.swift
//  AdyenAssignment
//
//  Created by Carlo André Aguilar on 19/12/22.
//

import MapKit

extension MKCoordinateRegion {
    var visibleRadiusInMeters: Int {
        let centralLocation = CLLocation (latitude: center.latitude, longitude: center.longitude)
        let outerRadiusLongitude: Double = centralLocation.coordinate.longitude - span.longitudeDelta/2
        let outerRadiusLocation = CLLocation(latitude: centralLocation.coordinate.latitude, longitude: outerRadiusLongitude)
        let radius = centralLocation.distance(from: outerRadiusLocation)
        return Int(radius)
    }
}
