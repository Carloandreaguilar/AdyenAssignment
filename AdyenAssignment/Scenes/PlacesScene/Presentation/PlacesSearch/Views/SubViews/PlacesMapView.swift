//
//  MapView.swift
//  AdyenAssignment
//
//  Created by Carlo André Aguilar on 13/12/22.
//

import SwiftUI
import CoreLocation
import MapKit

extension PlacesSearchView {
    struct PlacesMapView: View {
        @Binding var region: MKCoordinateRegion
        var places: [Place]
        
        var body: some View {
            Map(coordinateRegion: $region, annotationItems: places) { place in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: place.coordinates.latitude, longitude: place.coordinates.longitude)) {
                    MapAnnotationView(place: place)
                }
            }
        }
    }
}

struct PlacesMapView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesSearchView.PlacesMapView(region: .constant(MKCoordinateRegion.amsterdam), places: Place.listExample)
    }
}
