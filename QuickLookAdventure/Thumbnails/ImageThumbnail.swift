//
//  ImageThumbnail.swift
//  QuickLookAdventure
//
//  Created by Elfo on 17/11/2024.
//

import SwiftUI

/// A view that renders a thumbnail representation of an image.
///
/// It supports both iOS and macOS platforms with platform-specific behavior and styles.
struct ImageThumbnail: View {
    
    let resource: Resource
    
    @State private var cgImage: CGImage? = nil
    
#if os(iOS)
    /// The original size of the thumbnail.
    @State private var size: CGSize? = nil
    
    @ViewBuilder
    private var iOSThumbnail: some View {
        if let cgImage {
            if let size {
                showIOSThumbnail(resource, cgImage, size)
            } else {
                getThumbnailSize(resource, cgImage, $size)
            }
        } else {
            FetchingThumbnail(
                resource: resource,
                cgImage: $cgImage
            )
        }
    }
#endif

#if os(macOS)
    private var macOSThumbnail: some View {
        FetchingThumbnail(resource: resource, cgImage: $cgImage)
            .scaledToFit()
            .border(.black.secondary, width: 0.3)
            .padding(3)
            .background {
                Rectangle()
                    .foregroundStyle(.white)
            }
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
    ImageThumbnail(resource: Resource.sampleImage)
#if os(iOS)
        .frame(width: 90, height: 90)
#elseif os(macOS)
        .shadow(radius: 2)
        .frame(width: 90, height: 90)
        .padding()
#endif
}
