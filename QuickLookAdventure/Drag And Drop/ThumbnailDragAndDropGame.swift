//
//  ThumbnailDragAndDropGame.swift
//  QuickLookAdventure
//
//  Created by Elfo on 03/11/2024.
//

import SwiftUI

struct ThumbnailDragAndDropGame: View {
    @Binding var resources: [Resource]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Text("Thumbnail Drag and Drop Game")
                .font(.title)
                .padding(.bottom)
            
            HStack {
                Text("Drag and drop those thumbnails to the drop areas corresponding to their file types.")
                Spacer()
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(resources, id: \.name) { resource in
                        ThumbnailView(
                            resource: resource.name,
                            withExtension: resource.extension
                        )
                        .draggable(resource)
                    }
                }
            }
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(FileType.allCases, id: \.self) { fileType in
                        ThumbnailDropArea(
                            fileType: fileType,
                            resources: $resources
                        )
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

#Preview {
    @Previewable @State var resources: [Resource] = Resource.sampleData
    ThumbnailDragAndDropGame(resources: $resources)
}
