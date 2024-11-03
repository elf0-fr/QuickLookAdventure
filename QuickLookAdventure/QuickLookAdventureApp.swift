//
//  QuickLookAdventureApp.swift
//  QuickLookAdventure
//
//  Created by Elfo on 01/11/2024.
//

import SwiftUI
import SwiftData
import QuickLookUI

@main
struct QuickLookAdventureApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
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
            } else {
                ThumbnailGrid(resources: resources)
            }
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, QLPreviewPanelDelegate {
    func application(_ sender: NSApplication, openFile filename: String) -> Bool {
        return false
    }

    override func acceptsPreviewPanelControl(_ panel: QLPreviewPanel!) -> Bool {
        true
    }

    override func beginPreviewPanelControl(_ panel: QLPreviewPanel!) {
        DispatchQueue.main.async {
            panel.delegate = PreviewPanelController.shared
            panel.dataSource = PreviewPanelController.shared
        }
    }

    override func endPreviewPanelControl(_ panel: QLPreviewPanel!) {
        // Comment this line due to error :
        // -[QLPreviewPanel setDelegate:] called while the panel has no controller - Fix this or this will raise soon.
        // See comments in QLPreviewPanel.h for -acceptsPreviewPanelControl:/-beginPreviewPanelControl:/-endPreviewPanelControl:.
        
//        DispatchQueue.main.async {
//            print("endPreviewPanelControl")
//            panel.delegate = nil
//            panel.dataSource = nil
//        }
    }
}
