//
//  Place.swift
//  PlacesApp
//
//  Created by Carlo André Aguilar on 13/12/22.
//

import SwiftUI
import CoreLocation

struct Place: Identifiable, Hashable, NavigationPathValue {
    let id: String
    let name: String
    var distance: Int
    var coordinates: Coordinates
    var address: String?
    
    init(id: String, name: String, distance: Int, coordinates: Coordinates, address: String?) {
        self.id = id
        self.name = name
        self.distance = distance
        self.coordinates = coordinates
        self.address = address
    }
}

extension Place {
    init(fromDTO placeDTO: PlaceDTO) {
        self.id = placeDTO.id
        self.name = placeDTO.name
        self.distance = placeDTO.distance
        self.coordinates = placeDTO.geocodes.main
        self.address = placeDTO.location.address
    }
}
