//
//  PlacesResponse.swift
//  AdyenAssignment
//
//  Created by Carlo André Aguilar on 13/12/22.
//

import Foundation

struct PlaceSearchAPIResponse: Decodable {
    var results: [PlaceDTO]
}

struct PlaceDTO: Decodable {
    var id: String
    var name: String
    var distance: Int
    var geocodes: GeoCodes
    var location: Location
    
    enum CodingKeys: String, CodingKey {
        case id = "fsq_id"
        case name
        case distance
        case geocodes
        case location
    }
}

extension PlaceDTO {
    struct Icon: Decodable {
        var prefix: String
        var suffix: String
    }
    
    struct GeoCodes: Decodable {
        var main: Coordinates
    }
    
    struct Location: Decodable {
        var address: String?
    }
}

struct Coordinates: Codable, Equatable, Hashable {
    var latitude: Double
    var longitude: Double
}



