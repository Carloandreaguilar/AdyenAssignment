//
//  Example Data.swift
//  PlacesApp
//
//  Created by Carlo André Aguilar on 13/12/22.
//

import Foundation
import MapKit

#if DEBUG
extension Place {
    static let example = Place(id: "5238a1618bbd710537140e0a", name: "Hard Rock", distance: 500, coordinates: Coordinates(latitude: 52.3676, longitude: 4.9041), address: "10th Street")
    
    static let listExample = [Place(id: "1", name: "Hard Rock",  distance: 550, coordinates: Coordinates(latitude: 52.3672, longitude: 4.9039), address: "11th Street"), Place(id: "2", name: "McDonalds", distance: 550, coordinates: Coordinates(latitude: 52.3672, longitude: 4.9039), address: "11th Street"), Place(id: "3", name: "Starbucks", distance: 550, coordinates: Coordinates(latitude: 52.3672, longitude: 4.9039), address: "11th Street")]
}

extension MKCoordinateRegion {
    static let amsterdam = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.3676, longitude: 4.9041), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
}
#endif
