//
//  ThumbnailDragAndDropGame.swift
//  QuickLookAdventure
//
//  Created by Elfo on 03/11/2024.
//

import SwiftUI

struct ThumbnailDragAndDropGame: View {
    @Environment(DragAndDropViewModel.self) private var viewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.description)
                Spacer()
            }
            
            let resources = viewModel.resources
            ScrollView(.horizontal) {
                HStack {
                    ForEach(resources, id: \.name) { resource in
                        ThumbnailView(resource: resource)
                            .draggable(resource)
                    }
                }
            }
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(FileType.allCases, id: \.self) { fileType in
                        ThumbnailDropArea(fileType: fileType)
                    }
                }
            }
        }
        .navigationTitle(viewModel.title)
        .padding(.horizontal)
        .padding(.top)
    }
}

#Preview {
    @Previewable @State var viewModel = DragAndDropViewModel(resources: Resource.sampleData)
    
    NavigationStack {
        ThumbnailDragAndDropGame()
            .environment(viewModel)
    }
}
