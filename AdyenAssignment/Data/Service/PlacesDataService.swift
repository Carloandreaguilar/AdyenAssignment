//
//  PlacesDataService.swift
//  AdyenAssignment
//
//  Created by Carlo André Aguilar on 13/12/22.
//

import Foundation

enum PlacesSortType: String {
    case rating, relevance, distance
}

protocol PlacesDataServiceProtocol {
    func fetchPlaces(query: String?, radius: Int, sortType: PlacesSortType, itemsToLoad: Int, locationCoordinates: Coordinates) async throws -> [Place]
    func fetchPlacePhotos(id: String) async throws -> [PlacePhotoInfo]
}

struct PlacesDataService: PlacesDataServiceProtocol {
   
    let placesRepository: PlacesRepositoryProtocol
    
    func fetchPlaces(query: String?, radius: Int, sortType: PlacesSortType, itemsToLoad: Int, locationCoordinates: Coordinates) async throws -> [Place] {
        try await placesRepository.fetchPlaces(query: query, radius: radius, sortType: sortType, itemsToLoad: itemsToLoad, locationCoordinates: locationCoordinates)
    }
    
    func fetchPlacePhotos(id: String) async throws -> [PlacePhotoInfo] {
        try await placesRepository.fetchPlacePhotos(id: id)
    }
}


