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
    
    /// Tracks whether the grid allows selection.
    @State private var isSelectable: Bool = false
    /// Stores the indexes of selected thumbnails.
    @State private var selectedIndexes: [Int] = []
    @State private var selectedResource: URL?
    @State private var longPressingIndex: Int? = nil
    
    let columns = [
        GridItem(.adaptive(minimum: 100, maximum: 150), spacing: 20)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(Array(resources.enumerated()), id: \.element.name) {
                    index, resource in
                    SelectableThumbnail(
                        resource: resource,
                        index: index,
                        isSelected: isSelected(index),
                        selection: select
                    )
                    .scaleEffect(longPressingIndex == index ? 1.2 : 1.0)
                    .onLongPressGesture(minimumDuration: 0.5) {
                        selectedResource = resource.url
                    } onPressingChanged: { isPressing in
                        withAnimation(.easeInOut(duration: 0.5)) {
                            longPressingIndex = isPressing ? index : nil
                        }
                    }
                    .quickLookPreview($selectedResource)
                }
            }
        }
        .padding()
        .navigationTitle("Thumbnail Grid")
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
    
    /// Check if a given index is selected.
    func isSelected(_ index: Int) -> Bool {
        selectedIndexes.contains(index)
    }
    
    /// Toggle the selection of a specific index.
    func toggleSelection(index: Int) {
        if let _index = selectedIndexes.firstIndex(of: index) {
            selectedIndexes.remove(at: _index)
        } else {
            selectedIndexes.append(index)
        }
    }
    
    /// Select a range of indexes (used for multi-selection gestures).
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
    
    /// Select a specific index, clearing other selections.
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
