//
//  ThumbnailView.swift
//  QuickLookAdventure
//
//  Created by Elfo on 01/11/2024.
//

import SwiftUI

struct ThumbnailView: View {
    var resource: String
    var withExtension: String
    
    @State private var cgImage: CGImage? = nil
    
    var body: some View {
        Group {
            if let cgImage = cgImage {
                Image(
                    decorative: cgImage,
                    scale: 1.0,
                    orientation: .up
                )
                .resizable()
                .scaledToFit()
            } else {
                ProgressView()
            }
        }
        .frame(width: 90, height: 90)
        .onAppear {
            Task {
                let thumbnail = await generateThumbnailRepresentation(
                    forResource: resource,
                    withExtension: withExtension
                )
                if let image = thumbnail?.cgImage {
                    cgImage = image
                }
            }
        }
    }
}

#Preview {
    VStack {
        ThumbnailView(resource: "SWE - UI Developer – Quick Look", withExtension: "png")
        ThumbnailView(resource: "QuickLook Thumbnailing | Apple Developer Documentation", withExtension: "pdf")
        ThumbnailView(resource: "nil", withExtension: "pdf")
    }
    .frame(width: 500, height: 300)
}
