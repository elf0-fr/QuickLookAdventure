//
//  ThumbnailGrid.swift
//  QuickLookAdventure
//
//  Created by Elfo on 01/11/2024.
//

import SwiftUI

struct ThumbnailGrid: View {
    var resources: [Resource]
    
    @State var selection: [Bool]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(resources: [Resource]) {
        self.resources = resources
        _selection = State(
            initialValue: Array(
                repeating: false,
                count: resources.count
            )
        )
    }
    
    var body: some View {
        VStack {
            Text("Thumbnail Grid")
                .font(.title)
                .padding(.bottom)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(Array(resources.enumerated()), id: \.element.name) {
                        index,
                        resource in
                        ClickableThumbnail(
                            resource: resource,
                            index: index,
                            selections: $selection
                        )
                        .frame(width: 100)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ThumbnailGrid(resources: Resource.sampleData)
        .frame(minWidth: 500)
}
