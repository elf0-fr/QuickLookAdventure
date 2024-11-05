//
//  ThumbnailView.swift
//  QuickLookAdventure
//
//  Created by Elfo on 01/11/2024.
//

import SwiftUI

struct ThumbnailView: View {
    var resource: Resource
    
    @State private var cgImage: CGImage? = nil
    
    @ViewBuilder
    private var thumbnail: some View {
        if let cgImage {
            Image(
                decorative: cgImage,
                scale: 1.0,
                orientation: .up
            )
            .resizable()
        } else {
            EmptyView()
        }
    }
    
    private var imageThumbnail: some View {
        thumbnail
            .scaledToFit()
            .border(.black.secondary, width: 0.3)
            .padding(3)
            .background {
                Rectangle()
                    .foregroundStyle(.white)
            }
    }
    
    private var textThumbnail: some View {
        thumbnail
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
    
    private var pdfThumbnail: some View {
        thumbnail
            .scaledToFit()
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
    
    private var audioThumbnail: some View {
        thumbnail
    }
    
    @State private var size: CGSize? = nil
    @ViewBuilder
    private var _videoThumbnail: some View {
        Rectangle()
        
        thumbnail
            .scaledToFit()
            .frame(width: size!.width, height: size!.height)
        
        Rectangle()
    }
    
    @ViewBuilder
    private var videoThumbnail: some View {
        if let size {
            if size.height / size.width < 0 {
                HStack(spacing: 0) {
                    _videoThumbnail
                }
                .padding(.horizontal, 10)
            } else {
                VStack(spacing: 0) {
                    _videoThumbnail
                }
                .padding(.vertical, 10)
            }
        } else {
            thumbnail
                .scaledToFit()
                .background {
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                size = geometry.size
                            }
                    }
                }
        }
    }
    
    var body: some View {
        Group {
            if let _ = cgImage, let fileType = resource.fileType {
                Group {
                    switch fileType {
                    case .image:
                        imageThumbnail
                    case .livePhoto:
                        imageThumbnail
                    case .text:
                        textThumbnail
                    case .pdf:
                        pdfThumbnail
                    case .audio:
                        audioThumbnail
                    case .video:
                        videoThumbnail
                    }
                }
                .shadow(radius: 2)
                .padding(5)
            } else {
                ProgressView()
            }
        }
        .frame(width: 90, height: 90)
        .onAppear {
            Task {
                guard let url = resource.url else {
                    return
                }
                
                let thumbnail = await generateThumbnailRepresentation(url: url)
                if let image = thumbnail?.cgImage {
                    cgImage = image
                }
            }
        }
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

#Preview("PNG") {
    ThumbnailView(
        resource: Resource.sampleData.first { $0.extension == "png" }!
    )
    .padding(50)
}

#Preview("TXT") {
    ThumbnailView(
        resource: Resource.sampleData.first { $0.extension == "txt" }!
    )
    .padding(50)
}

#Preview("PDF") {
    ThumbnailView(
        resource: Resource.sampleData.first { $0.extension == "pdf" }!
    )
    .padding(50)
}
