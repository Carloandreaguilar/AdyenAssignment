//
//  PlacesSearchViewModel.swift
//  AdyenAssignment
//
//  Created by Carlo André Aguilar on 13/12/22.
//

import SwiftUI
import MapKit
import CoreLocation
import Combine

extension PlacesSearchView {
    @MainActor class ViewModel: ObservableObject {
        let navigationTitle = "Places"
        private let placesDataService: PlacesDataServiceProtocol
        lazy var radiusInMeters: Int  = region.visibleRadiusInMeters
        private var locationManager = LocationManager()
        private var mapRefreshTimer: Timer?
        private lazy var fetchPlacesTask = Task {}
        private var subscriptions = Set<AnyCancellable>()
        @Published var isFirstTimeLoading = true
        @Published var isLoadingLocation = false
        @Published var searchText: String = ""
        @Published var placesViewMode: PlacesViewMode = .list
        @Published private(set) var places: [Place] = []
        @Published var region: MKCoordinateRegion = MKCoordinateRegion(center: Defaults.amsterdamLocation, span: Defaults.defaultMapSpan) {
            didSet {
                guard !isFirstTimeLoading else {
                    return
                }
                self.refreshMapWithTimer()
            }
        }
        @Published var sortType: PlacesSortType = .rating {
            didSet {
                startFetchPlacesTask()
            }
        }
        
        init(placesDataService: PlacesDataServiceProtocol) {
            self.placesDataService = placesDataService
            observeLocationChange()
            requestCurrentLocation()
        }
        
        func fetchPlaces() async throws {
            guard !isLoadingLocation else {
                return
            }
            do {
                try places = await placesDataService.fetchPlaces(query: searchText, radius: region.visibleRadiusInMeters, sortType: sortType, itemsToLoad: Defaults.itemsToLoad, locationCoordinates: Coordinates(latitude: region.center.latitude, longitude: region.center.longitude))
            } catch {
                throw error
            }
            isFirstTimeLoading = false
        }
        
        func startFetchPlacesTask() {
            fetchPlacesTask.cancel()
            self.fetchPlacesTask = Task {
                do {
                    try await self.fetchPlaces()
                } catch {
                    print(error)
                }
            }
        }
    }
}

// MARK: - Location handling
extension PlacesSearchView.ViewModel {
    func requestCurrentLocation() {
        isLoadingLocation = true
        locationManager.requestLocation()
    }
    
    private func observeLocationChange() {
        locationManager.location.sink { location in
            self.region = MKCoordinateRegion(center: location ?? Defaults.amsterdamLocation, span: Defaults.defaultMapSpan)
            self.startFetchPlacesTask()
            self.isLoadingLocation = false
        }.store(in: &subscriptions)
    }
}

// MARK: - Map gesture handling
extension PlacesSearchView.ViewModel {
    // Invalidating and adding delay to only refresh data when the map stops dragging/panning
    private func refreshMapWithTimer() {
        mapRefreshTimer?.invalidate()
        mapRefreshTimer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) { _ in
            self.radiusInMeters = self.region.visibleRadiusInMeters
            self.startFetchPlacesTask()
        }
    }
}

// MARK: - Default Data
extension PlacesSearchView.ViewModel {
    struct Defaults {
        static let amsterdamLocation = CLLocationCoordinate2D(latitude: 52.3676, longitude: 4.9041)
        static let defaultMapSpan = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        static let itemsToLoad = 10
    }
}

