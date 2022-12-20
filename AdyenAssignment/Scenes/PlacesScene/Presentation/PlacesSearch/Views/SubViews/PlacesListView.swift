//
//  PlacesListView.swift
//  AdyenAssignment
//
//  Created by Carlo André Aguilar on 13/12/22.
//

import SwiftUI

extension PlacesSearchView {
    struct PlacesListView: View {
        var places: [Place]
        
        var body: some View {
            List {
                ForEach(places) { place in
                    NavigationLink(value: PlacesCoordinator.Destination.detail(place: place)) {
                        PlaceItemRowView(place: place)
                    }.listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .padding()
                        .background(.gray.opacity(0.3))
                        .cornerRadius(10)
                }
                
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .background(.ultraThinMaterial)
        }
    }
}

struct PlacesListView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesSearchView.PlacesListView(places: Place.listExample)
    }
}
