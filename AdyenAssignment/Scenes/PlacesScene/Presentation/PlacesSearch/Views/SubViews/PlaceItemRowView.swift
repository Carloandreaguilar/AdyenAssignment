//
//  PlaceItemRowView.swift
//  PlacesApp
//
//  Created by Carlo André Aguilar on 13/12/22.
//

import SwiftUI

extension PlacesSearchView {
    struct PlaceItemRowView: View {
        let place: Place
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(place.name).font(.headline)
                if let address = place.address {
                    Text(address).font(.subheadline)
                }
                Text(DistanceFormatter.formattedDistanceAway(distanceInMeters: place.distance))
                    .font(.footnote)
                    .foregroundColor(.black.opacity(0.5))
            }
        }
    }
}

struct PlaceItemRow_Previews: PreviewProvider {
    static var previews: some View {
        PlacesSearchView.PlaceItemRowView(place: Place.example)
    }
}
