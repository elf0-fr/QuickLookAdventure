//
//  TextThumbnail.swift
//  QuickLookAdventure
//
//  Created by Elfo on 17/11/2024.
//

import SwiftUI

/// A view that renders a thumbnail representation of a text document.
///
/// It supports both iOS and macOS platforms with platform-specific behavior and styles.
struct TextThumbnail: View {
    
    let resource: Resource
    
    @State private var cgImage: CGImage? = nil
    
#if os(iOS)
    private var iOSThumbnail: some View {
        FetchingThumbnail(resource: resource, cgImage: $cgImage)
            .aspectRatio(0.707, contentMode: .fit)
            .padding(4)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke()
                    .foregroundStyle(.black.tertiary)
            }
    }
#endif
    
#if os(macOS)
    private var macOSThumbnail: some View {
        FetchingThumbnail(resource: resource, cgImage: $cgImage)
            .aspectRatio(0.707, contentMode: .fit)
            .padding(4)
            .background {
                Rectangle()
                    .foregroundStyle(.white)
            }
            .clipShape(RoundedRectangle(cornerRadius: 2))
            .overlay(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 3)
                    .foregroundStyle(.white)
                    .frame(width: 23, height: 23)
                    .shadow(radius: 2, x: -2, y: 1)
            }
            .clipShape(
                TopRightCutShape(
                    cutSize: 25,
                    cornerRadius: 10
                )
            )
    }
#endif
    
    var body: some View {
#if os(iOS)
        iOSThumbnail
#elseif os(macOS)
        macOSThumbnail
#else
        Text("Unsupported platform")
#endif
    }
}

#Preview {
    TextThumbnail(resource: Resource.sampleText)
#if os(iOS)
        .frame(width: 90, height: 90)
#elseif os(macOS)
        .shadow(radius: 2)
        .frame(width: 90, height: 90)
        .padding()
#endif
}
