//
//  ThumbnailView.swift
//  QuickLookAdventure
//
//  Created by Elfo on 01/11/2024.
//

import SwiftUI

/// A view designed to display thumbnails for various resource types.
struct ThumbnailView: View {
    
    var resource: Resource
    
    var body: some View {
        Group {
            if let fileType = resource.fileType {
                Group {
                    switch fileType {
                    case .image:
                        ImageThumbnail(resource: resource)
                    case .livePhoto:
                        ImageThumbnail(resource: resource)
                    case .text:
                        TextThumbnail(resource: resource)
                    case .pdf:
                        PDFThumbnail(resource: resource)
                    case .audio:
                        RawThumbnail(resource: resource, cgImage: nil)
                    case .video:
                        VideoThumbnail(resource: resource)
                    }
                }
#if os(macOS)
                .shadow(radius: 2)
#endif
                .padding(5)
            } else {
                ProgressView()
            }
        }
        .frame(width: 90, height: 90)
    }
}

#Preview("All") {
    HStack {
        ForEach(Resource.sampleData, id: \.name) { resource in
            ThumbnailView(resource: resource)
                .padding(.horizontal)
        }
        
//        ThumbnailView(resource: Resource(name: "nil", extension: "nil"))
    }
    .padding(50)
}

/// A function to determine the size of a thumbnail.
///
/// This helps to ensure thumbnails are displayed correctly for given dimensions.
@MainActor
func getThumbnailSize(
    _ resource: Resource,
    _ cgImage: CGImage,
    _ size: Binding<CGSize?>
) -> some View {
    RawThumbnail(resource: resource, cgImage: cgImage)
        .scaledToFit()
        .background {
            GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        size.wrappedValue = geometry.size
                    }
            }
        }
}

#if os(iOS)
/// A function to render a properly styled thumbnail on iOS devices.
@MainActor
func showIOSThumbnail(
    _ resource: Resource,
    _ cgImage: CGImage,
    _ size: CGSize
) -> some View {
    VStack {
        if size.height < size.width {
            // If the thumbnail is wider than it is tall, add spacing at the top.
            Spacer()
        }
        
        RawThumbnail(resource: resource, cgImage: cgImage)
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .overlay {
                // Add a subtle border around the thumbnail.
                RoundedRectangle(cornerRadius: 5)
                    .stroke()
                    .foregroundStyle(.black.tertiary)
            }
    }
}
#endif
