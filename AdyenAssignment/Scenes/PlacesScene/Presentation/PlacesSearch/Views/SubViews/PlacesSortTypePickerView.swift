//
//  PlacesSortTypePickerView.swift
//  AdyenAssignment
//
//  Created by Carlo André Aguilar on 13/12/22.
//

import SwiftUI

extension PlacesSearchView {
    struct PlacesSortTypePickerView: View {
        @Binding var sortType: PlacesSortType
        
        var body: some View {
            Picker("Sort By", selection: $sortType, content: {
                Text("Rating")
                    .tag(PlacesSortType.rating)
                Text("Relevance")
                    .tag(PlacesSortType.relevance)
                Text("Distance")
                    .tag(PlacesSortType.distance)
            })
            .background(Rectangle().fill(.gray.opacity(0.1)))
            .cornerRadius(10)
        }
    }
}
struct PlacesSortTypePickerView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesSearchView.PlacesSortTypePickerView(sortType: .constant(.distance))
    }
}
