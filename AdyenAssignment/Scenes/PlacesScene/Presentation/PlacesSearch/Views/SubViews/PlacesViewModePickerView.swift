//
//  PlacesViewModePicker.swift
//  AdyenAssignment
//
//  Created by Carlo André Aguilar on 13/12/22.
//

import SwiftUI

extension PlacesSearchView {
    struct PlacesViewModePickerView: View {
        @Binding var viewMode: PlacesViewMode
        
        var body: some View {
            Picker("ViewMode", selection: $viewMode, content: {
                Image(systemName: "list.dash").tag(PlacesViewMode.list)
                Image(systemName: "map").tag(PlacesViewMode.map)
            }).frame(width: 150).pickerStyle(SegmentedPickerStyle())
        }
    }
}

struct PlacesViewModePicker_Previews: PreviewProvider {
    static var previews: some View {
        PlacesSearchView.PlacesViewModePickerView(viewMode: .constant(.map))
    }
}
