//
//  VideoThumbnail.swift
//  QuickLookAdventure
//
//  Created by Elfo on 17/11/2024.
//

import SwiftUI

/// A view that renders a thumbnail representation of a video.
///
/// It supports both iOS and macOS platforms with platform-specific behavior and styles.
struct VideoThumbnail: View {
    
    let resource: Resource
    
    @State private var cgImage: CGImage? = nil
    /// The original size of the thumbnail.
    @State private var size: CGSize? = nil
    
#if os(iOS)
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
    @ViewBuilder
    private func showMacOSThumbnail(size: CGSize) -> some View {
        if size.height > size.width {
            HStack(spacing: 0) {
                Rectangle()
                    .frame(width: 10)
                
                RawThumbnail(resource: resource, cgImage: cgImage)
                    .scaledToFit()
                    .frame(width: size.width, height: size.height)
                
                Rectangle()
                    .frame(width: 10)
            }
        } else {
            VStack(spacing: 0) {
                Rectangle()
                    .frame(height: 10)
                
                RawThumbnail(resource: resource, cgImage: cgImage)
                    .scaledToFit()
                    .frame(width: size.width, height: size.height)
                
                Rectangle()
                    .frame(height: 10)
            }
        }
    }
    
    @ViewBuilder
    private var macOSThumbnail: some View {
        if let cgImage {
            if let size {
                showMacOSThumbnail(size: size)
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
    VideoThumbnail(resource: Resource.sampleVideo)
#if os(iOS)
        .frame(width: 90, height: 90)
#elseif os(macOS)
        .shadow(radius: 2)
        .frame(width: 90, height: 90)
        .padding()
#endif
}
