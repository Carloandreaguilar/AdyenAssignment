//
//  PlacesCoordinator.swift
//  AdyenAssignment
//
//  Created by Carlo André Aguilar on 19/12/22.
//

import SwiftUI

class PlacesCoordinator: PersistedCoordinator, ObservableObject {
    private var dependencies = Dependencies()
    
    enum Destination: Hashable, NavigationPathValue {
        case detail(place: Place)
    }
    
    func goBackToRoot() {
        path.removeLast(path.count)
    }
    
    func goBack() {
        path.removeLast()
    }
    
    @ViewBuilder @MainActor
    func initialView() -> some View {
        let viewModel = PlacesSearchView.ViewModel(placesDataService: dependencies.placesDataService)
        PlacesSearchView(viewModel: StateObject(wrappedValue: viewModel))
    }
    
    @ViewBuilder @MainActor
    func destinationView(forDestination destination: Destination) -> some View {
        switch destination {
        case .detail(let place):
            let viewModel = PlaceDetailView.ViewModel(place: place, placesDataService: dependencies.placesDataService)
            PlaceDetailView(viewModel: StateObject(wrappedValue: viewModel))
        }
    }
}

private extension PlacesCoordinator {
    struct Dependencies {
        let placesDataService: PlacesDataServiceProtocol = PlacesDataService(placesRepository: PlacesNetworkRepository())
    }
}


