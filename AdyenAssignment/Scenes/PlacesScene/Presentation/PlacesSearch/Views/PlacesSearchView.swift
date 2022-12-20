//
//  PlacesSearchView.swift
//  AdyenAssignment
//
//  Created by Carlo André Aguilar on 13/12/22.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct PlacesSearchView: View {
    @StateObject private var viewModel: ViewModel
    @EnvironmentObject var coordinator: PlacesCoordinator
    
    init(viewModel: StateObject<ViewModel>) {
        _viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack {
                PlacesViewModePickerView(viewMode: $viewModel.placesViewMode)
                Spacer()
                PlacesSortTypePickerView(sortType: $viewModel.sortType)
                
                    .background(Rectangle().fill(.gray.opacity(0.2)))
                    .cornerRadius(10)
            }.padding(Edge.Set.horizontal)
                .padding(Edge.Set.bottom, 5)
            
            GeometryReader { geometry in
                ZStack(alignment: .bottomTrailing) {
                    PlacesMapView(region: $viewModel.region, places: viewModel.places)
                        .ignoresSafeArea()
                    Button(action: {
                        viewModel.requestCurrentLocation()
                    }, label: {
                        Image(systemName: "location.circle")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 27)
                            .padding(8)
                    })
                    .buttonStyle(BorderedButtonStyle())
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .padding()
                    
                    if viewModel.placesViewMode == .list {
                        PlacesListView(places: viewModel.places)
                            .padding(Edge.Set.bottom, geometry.safeAreaInsets.bottom)
                            .refreshable {
                                try? await viewModel.fetchPlaces()
                            }
                            .ignoresSafeArea()
                        
                    }
                    if viewModel.isFirstTimeLoading || viewModel.isLoadingLocation {
                        ProgressView()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .background(.ultraThinMaterial)
                    }
                }
                .navigationTitle(viewModel.navigationTitle)
                .searchable(text: $viewModel.searchText).onSubmit(of: .search) {
                    viewModel.startFetchPlacesTask()
                }.onChange(of: viewModel.searchText) { newText in
                    if newText.isEmpty {
                        viewModel.startFetchPlacesTask()
                    }
                }
            }
        }.onAppear() {
            viewModel.startFetchPlacesTask()
        }
    }
}

extension PlacesSearchView {
    enum PlacesViewMode {
        case list, map
    }
}

struct PlacesSearchView_Previews: PreviewProvider {
    static var previews: some View {
        let placesCoordinator = PlacesCoordinator()
        placesCoordinator.initialView()
    }
}
