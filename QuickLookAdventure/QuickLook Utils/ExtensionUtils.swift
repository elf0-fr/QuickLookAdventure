//
//  ExtensionUtils.swift
//  QuickLookAdventure
//
//  Created by Elfo on 03/11/2024.
//

import Foundation

enum FileType: String, CaseIterable {
    case image
    case livePhoto = "live photo"
    case text = "text file"
    case pdf = "PDF"
    case audio = "audio file"
    case video = "video file"
    
    func isValidFileType(_ fileExtension: String) -> Bool {
        switch self {
        case .image:
            return ImageExtension.isValidImageExtension(fileExtension)
            
        case .livePhoto:
            // TODO: add live photo support.
            return false
            
        case .text:
            return fileExtension.lowercased() == "txt"
            
        case .pdf:
            return fileExtension.lowercased() == "pdf"
        
        case .audio:
            return AudioFileExtension.isValidAudioExtension(fileExtension)
            
        case .video:
            return VideoFileExtension.isValidVideoExtension(fileExtension)
        }
    }
}

/// Enumeration representing common images extensions.
enum ImageExtension: String, CaseIterable {
    case jpg = "jpg"
    case jpeg = "jpeg"
    case png = "png"
    case gif = "gif"
    case bmp = "bmp"
    case tiff = "tiff"
    case heic = "heic"
    case heif = "heif"
    case webp = "webp"
    case svg = "svg"

    /// Checks if a given file extension is a valid image extension.
    static func isValidImageExtension(_ fileExtension: String) -> Bool {
        return ImageExtension(rawValue: fileExtension.lowercased()) != nil
    }
    
    /// Returns all image extensions as an array of strings.
    static var allExtensions: [String] {
        return ImageExtension.allCases.map { $0.rawValue }
    }
}

/// Enumeration representing common audio file extensions.
enum AudioFileExtension: String, CaseIterable {
    case mp3 = "mp3"
    case wav = "wav"
    case aac = "aac"
    case flac = "flac"
    case ogg = "ogg"
    case m4a = "m4a"
    case wma = "wma"
    case alac = "alac"
    case opus = "opus"
    case amr = "amr"

    /// Checks if a given file extension is a valid audio file extension.
    static func isValidAudioExtension(_ fileExtension: String) -> Bool {
        return AudioFileExtension(rawValue: fileExtension.lowercased()) != nil
    }
    
    /// Returns all audio file extensions as an array of strings.
    static var allExtensions: [String] {
        return AudioFileExtension.allCases.map { $0.rawValue }
    }
}

/// Enumeration representing common video file extensions.
enum VideoFileExtension: String, CaseIterable {
    case mp4 = "mp4"
    case mov = "mov"
    case avi = "avi"
    case mkv = "mkv"
    case flv = "flv"
    case wmv = "wmv"
    case webm = "webm"
    case mpeg = "mpeg"
    case mpg = "mpg"
    case m4v = "m4v"
    case ogv = "ogv"
    
    /// Checks if a given file extension is a valid video file extension.
    static func isValidVideoExtension(_ fileExtension: String) -> Bool {
        return VideoFileExtension(rawValue: fileExtension.lowercased()) != nil
    }
    
    /// Returns all video file extensions as an array of strings.
    static var allExtensions: [String] {
        return VideoFileExtension.allCases.map { $0.rawValue }
    }
}

extension String {
    var fileType: FileType? {
        if ImageExtension.isValidImageExtension(self) {
            return .image
        } else if self.lowercased() == "txt" {
            return .text
        } else if self.lowercased() == "pdf" {
            return .pdf
        } else if AudioFileExtension.isValidAudioExtension(self) {
            return .audio
        } else if VideoFileExtension.isValidVideoExtension(self) {
            return .video
        } else {
            return nil
        }
    }
}
