//
//  PlacesSearchViewModel.swift
//  AdyenAssignment
//
//  Created by Carlo André Aguilar on 13/12/22.
//

import SwiftUI
import MapKit

extension PlaceDetailView {
    @MainActor class ViewModel: ObservableObject {
        let place: Place
        let navigationTitle = "Info"
        let dummyImageURL = "https://s3-symbol-logo.tradingview.com/adyen--600.png"
        private let placesDataService: PlacesDataServiceProtocol
        @Published private(set) var photosInfo: [PlacePhotoInfo] = []
        
        init(place: Place, placesDataService: PlacesDataServiceProtocol) {
            self.place = place
            self.placesDataService = placesDataService
        }
        
        func fetchPhotos() async throws {
            photosInfo = try await placesDataService.fetchPlacePhotos(id: place.id)
        }
    }
}
