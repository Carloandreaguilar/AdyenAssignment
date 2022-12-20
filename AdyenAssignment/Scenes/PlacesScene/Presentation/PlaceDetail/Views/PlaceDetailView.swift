//
//  PlaceDetailView.swift
//  PlacesApp
//
//  Created by Carlo André Aguilar on 13/12/22.
//

import SwiftUI
import MapKit

struct PlaceDetailView: View {
    @StateObject private var viewModel: ViewModel
    @EnvironmentObject var coordinator: PlacesCoordinator
    let imagePadding = 20.0
    
    init(viewModel: StateObject<ViewModel>) {
        _viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack(alignment: .leading) {
                if viewModel.photosInfo.isEmpty {
                    ProgressView()
                        .frame(width: geometry.size.width, height: geometry.size.width)
                        
                } else {
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(viewModel.photosInfo, id: \.self) { photoInfo in
                                AsyncImage(url: URL(string: viewModel.dummyImageURL), content: { image in
                                    image.resizable()
                                }, placeholder: {
                                    Rectangle()
                                        .fill(.gray.opacity(0.25))
                                        .overlay(ProgressView())
                                })
                                .cornerRadius(10)
                                .aspectRatio(contentMode: .fit)
                                .frame(height: abs(imageWidth(boundsWidth: geometry.size.width)))
                            }
                        }
                        .padding(imagePadding)
                    }.fixedSize(horizontal: false, vertical: true)
                    
                }
                Text(viewModel.place.name)
                    .font(.largeTitle)
                    .bold()
                    .padding(Edge.Set.horizontal)
                    .navigationTitle(viewModel.navigationTitle)
                    .navigationBarTitleDisplayMode(.inline)
                if let address = viewModel.place.address {
                    Text(address)
                        .font(.title2)
                        .padding(Edge.Set.horizontal)
                }
                Text(DistanceFormatter.formattedDistanceAway(distanceInMeters: viewModel.place.distance))
                    .padding(Edge.Set.horizontal)
            }
            .onAppear() {
                Task {
                    try? await viewModel.fetchPhotos()
                }
            }
        }
    }
    
    func imageWidth(boundsWidth: Double) -> Double {
        return boundsWidth - (imagePadding * 2)
    }
}

struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let placesCoordinator = PlacesCoordinator()
        placesCoordinator.destinationView(forDestination: .detail(place: Place.example))
    }
}
