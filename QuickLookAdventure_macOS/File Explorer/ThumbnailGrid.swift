//
//  ThumbnailGrid.swift
//  QuickLookAdventure
//
//  Created by Elfo on 01/11/2024.
//

import SwiftUI
import QuickLook

struct ThumbnailGrid: View {
    
    let resources: [Resource]
    
    @State private var selectedIndexes: [Int] = []
    @State private var isCommandDown: Bool = false
    @State private var isShiftDown: Bool = false
    @State private var selectedResource: URL?
    
    let columns = [
        GridItem(.adaptive(minimum: 100, maximum: 150), spacing: 20)
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
                        SelectableThumbnail(
                            resource: resource,
                            index: index,
                            isSelected: isSelected(index),
                            selection: select
                        )
                        .contextMenu {
                            Button {
                                selectedResource = resource.url
                            } label: {
                                Label("Preview", systemImage: "eye")
                                    .labelStyle(.titleAndIcon)
                            }
                        }
                        .quickLookPreview($selectedResource)
                    }
                }
            }
        }
        .padding()
        .onModifierKeysChanged(mask: .command) { old, new in
            isCommandDown = !new.isEmpty
        }
        .onModifierKeysChanged(mask: .shift) { old, new in
            isShiftDown = !new.isEmpty
        }
        .onKeyPress(.space, action: previewOnMacOS)
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
        if !isShiftDown && !isCommandDown {
            // Deselection all the previous selected thumbnails
            // excepted the one at index 'index'.
            selectedIndexes.removeAll { $0 != index }
            toggleSelection(index: index)
            
        } else if isCommandDown {
            // Only deselect or select the thumbnail at index 'index'
            toggleSelection(index: index)
            
        } else {
            // Selection a rage of thumbnails.
            let lastIndex = selectedIndexes.last
            if let lastIndex {
                selectRange(from: lastIndex, to: index)
            } else {
                toggleSelection(index: index)
            }
        }
    }
    
    func previewOnMacOS() -> KeyPress.Result {
        if (PreviewPanelController.shared.isVisible) {
            PreviewPanelController.shared.hidePreview()
        } else {
            guard !selectedIndexes.isEmpty else {
                return .ignored
            }

            let _resources = selectedIndexes.sorted().map { resources[$0] }
            PreviewPanelController.shared.showPreview(resources: _resources)
        }
        
        return .handled
    }
}

#Preview {
    NavigationStack {
        ThumbnailGrid(resources: Resource.sampleData)
            .frame(minWidth: 500)
    }
}
