//
//  RawThumbnail.swift
//  QuickLookAdventure
//
//  Created by Elfo on 16/11/2024.
//

import SwiftUI

struct RawThumbnail: View {
    
    let resource: Resource
    let cgImage: CGImage?

    var body: some View {
        if let cgImage {
            Image(
                decorative: cgImage,
                scale: 1.0,
                orientation: .up
            )
            .resizable()
        } else {
            ProgressView()
        }
    }
}
