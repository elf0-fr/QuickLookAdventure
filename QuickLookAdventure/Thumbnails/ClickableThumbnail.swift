//
//  ClickableThumbnail.swift
//  QuickLookAdventure
//
//  Created by Elfo on 01/11/2024.
//

import SwiftUI

struct ClickableThumbnail: View {
    
    /// The resource that will be display as a thumbnail.
    let resource: Resource
    /// The index of the resource in the list of displayed resources.
    let index: Int
    /// Whether the thumbnail is selected or not.
    let isSelected: Bool
    
    let selection: (Int) -> Void
    
    var body: some View {
        VStack {
            ThumbnailView(resource: resource)
                .frame(width: 100, height: 100)
                .background {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(.tertiary)
                    }
                }
            
            Text("\(resource.name).\(resource.extension)")
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.horizontal)
                .background {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 3)
                            .foregroundStyle(.blue)
                    }
                }
                .frame(maxWidth: 150)
                .fixedSize(horizontal: false, vertical: true)
        }
        .onTapGesture {
            selection(index)
        }
        .focusable()
        .focusEffectDisabled()
    }
}

#Preview {
    @Previewable @State var isSelected: [Bool] = [false, false, false, false]
    
    VStack {
        ForEach(Array(Resource.sampleData.enumerated()), id: \.element.name) {
            index, resource in
            ClickableThumbnail(
                resource: resource,
                index: index,
                isSelected: isSelected[index],
                selection: { index in
                    isSelected[index].toggle()
                }
            )
        }
    }
    .frame(width: 500)
}
