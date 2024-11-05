//
//  Resource.swift
//  QuickLookAdventure
//
//  Created by Elfo on 02/11/2024.
//

import Foundation
import CoreTransferable
import UniformTypeIdentifiers

struct Resource: Codable, Equatable {
    let name: String
    let `extension`: String
    
    let url: URL?
    
    var fileType: FileType? {
        self.extension.fileType
    }
    
    init(name: String, `extension`: String) {
        self.name = name
        self.extension = `extension`
        
        if let url = Bundle.main.url(forResource: name, withExtension: self.extension) {
            self.url = url
        } else {
            print("No URL found for resource: \(name) with extension: \(self.extension).")
            self.url = nil
        }
    }
    
    @MainActor static let sampleData: [Resource] = [
        .init(name: "SWE - UI Developer – Quick Look", extension: "png"),
        .init(name: "QuickLook Thumbnailing | Apple Developer Documentation", extension: "pdf"),
        .init(name: "Demo", extension: "mov"),
        .init(name: "Text", extension: "txt"),
    ]
}

extension Resource: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .resource)
    }
}

extension UTType {
    static var resource: UTType {
        UTType(exportedAs: "com.romain-tirbisch.QuickLookAdventure.resource")
    }
}
