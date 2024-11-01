//
//  Item.swift
//  QuickLookAdventure
//
//  Created by Elfo on 01/11/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
