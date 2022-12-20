//
//  MapAnnotationView.swift
//  AdyenAssignment
//
//  Created by Carlo André Aguilar on 19/12/22.
//

import SwiftUI
import MapKit

struct MapAnnotationView: View {
    let place: Place
    let minimumTouchWidth = 44.0
    
    var body: some View {
        NavigationLink(value: PlacesCoordinator.Destination.detail(place: place)) {
            VStack {
                Image(systemName: "star.circle")
                    .resizable()
                    .foregroundColor(.red)
                    .frame(width: minimumTouchWidth, height: minimumTouchWidth)
                    .background(.white)
                    .clipShape(Circle())
                Text(place.name)
                    .font(.footnote)
                    .bold()
                    .background(.thinMaterial)
                    .cornerRadius(5)
            }
        }
    }
}

struct MapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        MapAnnotationView(place: Place.example)
    }
}
