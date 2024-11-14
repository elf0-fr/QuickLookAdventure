//
//  ThumbnailGrid.swift
//  QuickLookAdventure
//
//  Created by Elfo on 14/11/2024.
//

import SwiftUI
import QuickLook

struct ThumbnailGrid: View {
    
    let resources: [Resource]
    
    @State private var isSelectable: Bool = false
    @State private var selectedIndexes: [Int] = []
    @State private var selectedResource: URL?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Text("Thumbnail Grid")
                .font(.title)
                .padding(.bottom)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(Array(resources.enumerated()), id: \.element.name) {
                        index, resource in
                        ClickableThumbnail(
                            resource: resource,
                            index: index,
                            isSelected: isSelected(index),
                            selection: select
                        )
                        .frame(width: 100)
                        .onLongPressGesture {
                            selectedResource = resource.url
                        }
                        .quickLookPreview($selectedResource)
                    }
                }
            }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if isSelectable {
                    Button("Done") {
                        isSelectable = false
                        selectedIndexes.removeAll()
                    }
                } else {
                    Button {
                        isSelectable = true
                    } label: {
                        Image(systemName: "checkmark.circle")
                    }
                }
            }
        }
    }
    
    func isSelected(_ index: Int) -> Bool {
        selectedIndexes.contains(index)
    }
    
    func toggleSelection(index: Int) {
        if let _index = selectedIndexes.firstIndex(of: index) {
            selectedIndexes.remove(at: _index)
        } else {
            selectedIndexes.append(index)
        }
    }
    
    func selectRange(from: Int, to: Int) {
        let collection: any Collection<Int>
        if from < to {
            collection = from...to
        } else {
            collection = (to...from).reversed()
        }
        
        for i in collection {
            if selectedIndexes.firstIndex(of: i) == nil {
                selectedIndexes.append(i)
            }
        }
    }
    
    func select(index: Int) {
        guard isSelectable else { return }
        
        selectedIndexes.removeAll { $0 != index }
        toggleSelection(index: index)
    }
}

#Preview {
    NavigationStack {
        ThumbnailGrid(resources: Resource.sampleData)
    }
}
