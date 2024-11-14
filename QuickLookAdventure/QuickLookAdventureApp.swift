//
//  QuickLookAdventureApp.swift
//  QuickLookAdventure
//
//  Created by Elfo on 01/11/2024.
//

import SwiftUI
import SwiftData

@main
struct QuickLookAdventureApp: App {
#if os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
#endif
    
    @State private var resources: [Resource] = Resource.sampleData
    
    @State private var isDragAndDropCompleted: Bool = false

    var body: some Scene {
        WindowGroup {
            if !isDragAndDropCompleted {
                ThumbnailDragAndDropGame(resources: $resources)
                    .onChange(of: resources) {
                        if resources.isEmpty {
                            resources = Resource.sampleData
                            isDragAndDropCompleted = true
                        }
                    }
            }
            else {
                NavigationStack {
                    ThumbnailGrid(resources: resources)                    
                }
            }
        }
    }
}


