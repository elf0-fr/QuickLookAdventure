//
//  ClickableThumbnail.swift
//  QuickLookAdventure
//
//  Created by Elfo on 01/11/2024.
//

import SwiftUI

struct ClickableThumbnail: View {
    var resource: Resource
    var index: Int
    
    @Binding var selections: [Bool]
    
    var body: some View {
        VStack {
            ThumbnailView(resource: resource)
            .frame(width: 100, height: 100)
            .background {
                if selections[index] {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundStyle(.tertiary)
                }
            }
                
            
            Text("\(resource.name).\(resource.extension)")
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.horizontal)
                .background {
                    if selections[index] {
                        RoundedRectangle(cornerRadius: 3)
                            .foregroundStyle(.blue)
                    }
                }
                .frame(maxWidth: 150)
                .fixedSize(horizontal: false, vertical: true)
        }
        .onTapGesture {
            for i in selections.indices {
                if i != index {
                    selections[i] = false
                }
            }
            selections[index].toggle()
        }
        .focusable()
        .focusEffectDisabled()
        .onKeyPress(.space) {
            guard selections[index] else {
                return .ignored
            }
            
            guard let fileURL = resource.url else {
                print("unable to get file URL for \(resource.name).")
                return .ignored
            }
            
            PreviewPanelController.shared.showPreview(fileURL: fileURL)
            return .handled
        }
    }
}

#Preview {
    @Previewable @State var isSelected: [Bool] = [false, false, false]
    
    VStack {
        ForEach(Array(Resource.sampleData.enumerated()), id: \.element.name) {
            index,
            resource in
            ClickableThumbnail(
                resource: resource,
                index: index,
                selections: $isSelected
            )
        }
    }
    .frame(width: 500)
}
