//
//  QuickLookPreview.swift
//  QuickLookAdventure
//
//  Created by Elfo on 02/11/2024.
//

import SwiftUI
import QuickLookUI

@MainActor
class PreviewPanelController: NSObject, @preconcurrency QLPreviewPanelDataSource, QLPreviewPanelDelegate {
    static let shared = PreviewPanelController()
    private var fileURL: URL?

    func showPreview(fileURL: URL) {
        self.fileURL = fileURL
        if QLPreviewPanel.shared().isVisible {
            QLPreviewPanel.shared().reloadData()
        } else {
            QLPreviewPanel.shared().makeKeyAndOrderFront(nil)
        }
    }

    func numberOfPreviewItems(in panel: QLPreviewPanel!) -> Int {
        return fileURL != nil ? 1 : 0
    }

    func previewPanel(_ panel: QLPreviewPanel!, previewItemAt index: Int) -> QLPreviewItem! {
        return fileURL as QLPreviewItem?
    }
}
