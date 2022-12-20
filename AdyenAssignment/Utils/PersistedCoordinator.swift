//
//  PersistedCoordinator.swift
//  AdyenAssignment
//
//  Created by Carlo André Aguilar on 19/12/22.
//

import SwiftUI

typealias NavigationPathValue = Codable

/**** Saves Navigation state after reopening app */
class PersistedCoordinator {
    @Published var path = NavigationPath() {
        didSet {
            save()
        }
    }
    
    private let savePath: URL
    
    init() {
        savePath = URL.documentsDirectory.appending(path: "SavedPathStore")
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }
    }
    
    func save() {
        guard let representation = path.codable else { return }
        
        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
           }
       }
}
