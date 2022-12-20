//
//  PlacePhotosResponse.swift
//  AdyenAssignment
//
//  Created by Carlo André Aguilar on 13/12/22.
//

import Foundation

typealias PlacePhotosResponse = [PlacePhotoInfo]

struct PlacePhotoInfo: Decodable, Hashable {
    var id: String
    var prefix: String
    var suffix: String
    var width: Int
    var height: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case prefix
        case suffix
        case height
        case width
    }
    
    var imageData: Data?
    var imageUrl: String {
        prefix.dropLast() + suffix
    }
}
