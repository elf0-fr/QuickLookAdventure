//
//  QuickLookPreview.swift
//  QuickLookAdventure
//
//  Created by Elfo on 02/11/2024.
//

import SwiftUI
import QuickLookUI

@MainActor
class PreviewPanelController: NSObject, @preconcurrency QLPreviewPanelDataSource, @preconcurrency QLPreviewPanelDelegate {

    static let shared = PreviewPanelController()
    private var resource: Resource?

    func showPreview(resource: Resource) {
        self.resource = resource
        if QLPreviewPanel.shared().isVisible {
            QLPreviewPanel.shared().reloadData()
        } else {
            QLPreviewPanel.shared().makeKeyAndOrderFront(nil)
        }
    }

    // MARK: - QLPreviewPanelDataSource
    
    func numberOfPreviewItems(in panel: QLPreviewPanel!) -> Int {
        return resource != nil ? 1 : 0
    }

    func previewPanel(_ panel: QLPreviewPanel!, previewItemAt index: Int) -> QLPreviewItem! {
        return resource?.url as QLPreviewItem?
    }
    
    // MARK: - QLPreviewPanelDelegate
    
//    func previewPanel(_ panel: QLPreviewPanel!, transitionImageFor item: (any QLPreviewItem)!, contentRect: UnsafeMutablePointer<NSRect>!) -> Any! {
//        Task {
//            let thumbnail = await generateThumbnailRepresentation(url: resource!.url!)
//        }
//        let image = thumbnail.nsImage
//        
//        contentRect.pointee = NSRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
//        
//        // Retourner l'image de vignette pour la transition
//        return image
//    }
}
