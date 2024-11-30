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
    
    @State private var dragAndDropViewModel = DragAndDropViewModel(resources: Resource.sampleData)
    @State private var resources: [Resource] = Resource.sampleData
    
    @State private var isDragAndDropCompleted: Bool = false

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if !isDragAndDropCompleted {
                    ThumbnailDragAndDropGame()
                        .environment(dragAndDropViewModel)
                        .onChange(of: dragAndDropViewModel.isGameOver) {
                            if dragAndDropViewModel.isGameOver {
                                isDragAndDropCompleted = true
                            }
                        }
                }
                else {
                    ThumbnailGrid(resources: resources)
                }
            }
        }
    }
}


