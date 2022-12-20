//
//  MapView.swift
//  AdyenAssignment
//
//  Created by Carlo André Aguilar on 14/12/22.
//

import SwiftUI
import MapKit

extension PlacesSearchView {
    struct PlacesMapView: View {
        @Binding var region: MKCoordinateRegion
        
        var body: some View {
            Map(coordinateRegion: $region)
            Button(action: {
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
        }
    }
}

struct PlacesMapView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesSearchView.PlacesMapView(region: .constant(MKCoordinateRegion.amsterdam))
    }
}
