//
//  Debug.swift
//  QuickLookAdventure
//
//  Created by Elfo on 16/11/2024.
//

import OSLog

/// Logger subsystem.
private let subsystem = Bundle.main.bundleIdentifier!

/// Logs everything related to thumbnail.
let thumbnailLogger = Logger(subsystem: subsystem, category: "thumbnail")
