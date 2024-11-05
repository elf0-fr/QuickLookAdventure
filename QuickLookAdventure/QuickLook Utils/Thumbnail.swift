//
//  Thumbnail.swift
//  QuickLookAdventure
//
//  Created by Elfo on 01/11/2024.
//

import Foundation
@preconcurrency import QuickLookThumbnailing

@MainActor
func generateThumbnailRepresentation(forResource: String, withExtension: String) async -> QLThumbnailRepresentation? {
    // Set up the parameters of the request.
    guard let url = Bundle.main.url(forResource: forResource, withExtension: withExtension) else {
        
        // Handle the error
        print("No URL found for resource: \(forResource) with extension: \(withExtension).")
        return nil
    }
    
    return await generateThumbnailRepresentation(url: url)
}

@MainActor
func generateThumbnailRepresentation(url: URL) async -> QLThumbnailRepresentation? {
    
    // Create the thumbnail request.
    let request = QLThumbnailGenerator.Request(
        fileAt: url,
        size: CGSize(width: 90, height: 90),
        scale: 5.0,
        representationTypes: .all
    )
    
    // Retrieve the singleton instance of the thumbnail generator and generate the thumbnails.
    let generator = QLThumbnailGenerator.shared
    
    do {
        return try await generator.generateBestRepresentation(for: request)
    } catch {
        print("Error generating thumbnail: \(error)")
        return nil
    }
}

extension QLThumbnailRepresentation.RepresentationType: @retroactive CustomStringConvertible {
    public var description: String {
        switch self {
        case .icon:
            return "Icon"
        case .lowQualityThumbnail:
            return "Low Quality Thumbnail"
        case .thumbnail:
            return "Thumbnail"
        @unknown default:
            return "Unknown"
        }
    }
}
