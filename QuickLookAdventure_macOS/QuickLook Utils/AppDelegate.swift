//
//  AppDelegate.swift
//  QuickLookAdventure_macOS
//
//  Created by Elfo on 14/11/2024.
//

import QuickLookUI

@MainActor
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
        DispatchQueue.main.async {
            if let _ = panel.dataSource, let _ = panel.delegate {
                panel.dataSource = nil
                panel.delegate = nil
            }
        }
    }
}
