//
//  QuickLookPreview.swift
//  QuickLookAdventure
//
//  Created by Elfo on 02/11/2024.
//

import SwiftUI
import QuickLookUI

@MainActor
class PreviewPanelController: NSObject {

    static let shared = PreviewPanelController()
    
    private var resource: Resource?
    private var previewPanel: QLPreviewPanel?
    
    var isVisible: Bool {
        previewPanel?.isVisible ?? false
    }
    
    func showPreview(resource: Resource) {
        self.resource = resource
        previewPanel = QLPreviewPanel.shared()
        
        centerPreview()
        if previewPanel!.isVisible {
            previewPanel!.reloadData()
        } else {
            previewPanel!.makeKeyAndOrderFront(nil)
        }
    }
    
    func hidePreview() {
        previewPanel?.close()
    }
    
    func centerPreview() {
        let window = NSApplication.shared.mainWindow
        let screen = window?.screen
        
        if let screen, let previewPanel {
            let screenOrigin = screen.frame.origin
            let previewPanelSize = previewPanel.frame.size
            
            let newOrigin = CGPoint(
                x: screenOrigin.x + (screen.frame.width - previewPanelSize.width) / 2,
                y: screenOrigin.y + (screen.frame.height - previewPanelSize.height) / 2
            )
            
            previewPanel.setFrame(NSRect(origin: newOrigin, size: previewPanelSize), display: true, animate: false)
        }
    }
}

extension PreviewPanelController: @preconcurrency QLPreviewPanelDataSource {
    
    func numberOfPreviewItems(in panel: QLPreviewPanel!) -> Int {
        return resource != nil ? 1 : 0
    }
    
    func previewPanel(_ panel: QLPreviewPanel!, previewItemAt index: Int) -> QLPreviewItem! {
        return resource?.url as QLPreviewItem?
    }
}

extension PreviewPanelController: @preconcurrency QLPreviewPanelDelegate {
     
    // I didn't manage to understand how this method works.
//    func previewPanel(_ panel: QLPreviewPanel!, sourceFrameOnScreenFor item: (any QLPreviewItem)!) -> NSRect {
//        print("previewPanel zoom effect")
//        return NSRect(origin: CGPoint(x: 10, y: 10), size: CGSize(width: 100, height: 100))
//    }
    
    // Watch for input event.
//    func previewPanel(_ panel: QLPreviewPanel!, handle event: NSEvent!) -> Bool {
//        guard event.type == .keyDown else { return false }
//        
//        print("Keydown event with key: \(event.characters!)")
//        return true
//    }
    
    // I didn't manage to get this method to be called.
//    func previewPanel(_ panel: QLPreviewPanel!, transitionImageFor item: (any QLPreviewItem)!, contentRect: UnsafeMutablePointer<NSRect>!) -> Any! {
//        print("previewPanel transitionImageFor")
//        return nil
//    }
}
