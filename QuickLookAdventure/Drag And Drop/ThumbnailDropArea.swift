//
//  ThumbnailDropArea.swift
//  QuickLookAdventure
//
//  Created by Elfo on 03/11/2024.
//

import SwiftUI

struct ThumbnailDropArea: View {
    
    @Environment(DragAndDropViewModel.self) private var viewModel
    // State variable to control the shaking effect
    @State private var isShaking = false
    
    var fileType: FileType
    
    var body: some View {
        ZStack {
            Text("Drag and drop \(fileType)s here")
                .padding(2)
            
            RoundedRectangle(cornerRadius: 8)
                .stroke(.blue, lineWidth: 2)
        }
        .dropDestination(for: Resource.self, action: dropAction)
        .frame(maxWidth: 200, minHeight: 100, maxHeight: 100)
        .padding()
        .offset(x: isShaking ? -10 : 0) // Apply horizontal offset when shaking
        .animation(
            Animation.linear(duration: 0.1) // Quick back-and-forth animation
                .repeatCount(5, autoreverses: true), // Repeat animation to create shake effect
            value: isShaking
        )
    }
    
    func dropAction(resources: [Resource], location: CGPoint) -> Bool {
        return viewModel.dropAction(
            resources: resources,
            fileType: fileType
        ) {
            // Trigger the shaking effect
            isShaking = true
            // Reset isShaking to false after the animation is done
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isShaking = false
            }
        }
    }
}

#Preview {
    @Previewable @State var viewModel = DragAndDropViewModel(resources: Resource.sampleData)
    
    ThumbnailDropArea(fileType: FileType.image)
        .environment(viewModel)
}
