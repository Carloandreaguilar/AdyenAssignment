//
//  PlacesScene.swift
//  AdyenAssignment
//
//  Created by Carlo André Aguilar on 19/12/22.
//

import SwiftUI

struct PlacesScene: View {
    @ObservedObject var placesCoordinator = PlacesCoordinator()
    
    var body: some View {
        NavigationStack(path: $placesCoordinator.path) {
            placesCoordinator.initialView()
                .navigationDestination(for: PlacesCoordinator.Destination.self) { destination in
                    placesCoordinator.destinationView(forDestination: destination)
                }
        }
        .environmentObject(placesCoordinator)
    }
}

struct PlacesScene_Previews: PreviewProvider {
    static var previews: some View {
        PlacesScene()
    }
}
