//
//  FetchingThumbnail.swift
//  QuickLookAdventure
//
//  Created by Elfo on 17/11/2024.
//

import SwiftUI

/// A view that displays a thumbnail image for a given resource.
///
/// If the thumbnail is already available, it displays the image. Otherwise, it shows a progress indicator while asynchronously fetching the thumbnail.
struct FetchingThumbnail: View {
    
    let resource: Resource
    @Binding var cgImage: CGImage?
    
    var body: some View {
        if let cgImage {
            RawThumbnail(
                resource: resource,
                cgImage: cgImage
            )
        } else {
            ProgressView()
                .onAppear(perform: fetchThumbnailImage)
        }
    }
    
    /// Fetches the thumbnail image for the given resource asynchronously.
    @MainActor
    func fetchThumbnailImage() {
        Task {
            guard let url = resource.url else {
                thumbnailLogger.error("No URL for \(resource.name).\(resource.extension).")
                return
            }
            
            let thumbnail = await generateThumbnailRepresentation(url: url)
            if let image = thumbnail?.cgImage {
                thumbnailLogger.notice("Thumbnail image found for \(resource.name).\(resource.extension).")
                cgImage = image
            } else {
                thumbnailLogger.error("Thumbnail image not found for \(resource.name).\(resource.extension).")
            }
        }
    }
}

#Preview {
    @Previewable @State var cgImage: CGImage? = nil
    
    FetchingThumbnail(
        resource: Resource.sampleData[0],
        cgImage: $cgImage
    )
    .frame(width: 90, height: 90)
#if os(macOS)
        .padding()
#endif
}
