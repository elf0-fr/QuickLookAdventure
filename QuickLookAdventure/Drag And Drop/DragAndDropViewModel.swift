//
//  DragAndDropViewModel.swift
//  QuickLookAdventure
//
//  Created by Elfo on 30/11/2024.
//

import SwiftUI


@Observable
class DragAndDropViewModel {
    
    // MARK: - Init
    
    init(resources: [Resource]) {
        self.resources = resources
    }
    
    // MARK: - Model
    
    var resources: [Resource]
    
    // MARK: - Outputs
    
    let title = "Drag and Drop Game"
    let description = "Drag and drop those thumbnails to the drop areas corresponding to their file types."
    
    var isGameOver: Bool {
        resources.isEmpty
    }
        
    // MARK: - Inputs
    
    func dropAction(resources: [Resource], fileType: FileType, failHandler: () -> Void) -> Bool {
        guard let resource = resources.first, fileType.isValidFileType(resource.extension) else {
            failHandler()
            
            return false
        }
        
        withAnimation {
            remove(resource: resource)
        }
        return true
    }
    
    func remove(resource: Resource) {
        if let index = resources.firstIndex(of: resource) {
            resources.remove(at: index)
        }
    }
}
