//
//  TopRightCutShape.swift
//  QuickLookAdventure
//
//  Created by Elfo on 04/11/2024.
//

import SwiftUI

struct TopRightCutShape: Shape {
    var cutSize: CGFloat // The size of the cut corner
    var cornerRadius: CGFloat // Radius for the rounded endpoints of the cut
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Start from the top-left corner and move clockwise
        path.move(to: CGPoint(x: 0, y: 0)) // Top-left
        path.addLine(to: CGPoint(x: rect.width - cutSize, y: 0)) // Move close to the top-right cut start
        
        // Create a rounded arc at the start of the cut
        path.addArc(
            center: CGPoint(x: rect.width - cutSize, y: cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(-90),
            endAngle: .degrees(-45),
            clockwise: false
        )
        
        // the point is now at:
        // x = rect.width - cutSize + cornerRadius * cos(.pi / 4.0)
        // y = cornerRadius * sin(.pi / 4.0)
        
        // Create the straight cut line
        path.addLine(
            to: CGPoint(
                x: rect.width - (cornerRadius - cornerRadius * cos(.pi / 4.0)),
                y: cutSize - cornerRadius * sin(.pi / 4.0)
            )
        )
        
        // Create a rounded arc at the end of the cut
        path.addArc(
            center: CGPoint(x: rect.width - cornerRadius, y: cutSize),
            radius: cornerRadius,
            startAngle: .degrees(-45),
            endAngle: .degrees(0),
            clockwise: false
        )
        
        // Continue the path around the rectangle
        path.addLine(to: CGPoint(x: rect.width, y: rect.height)) // Bottom-right
        path.addLine(to: CGPoint(x: 0, y: rect.height)) // Bottom-left
        path.closeSubpath()
        
        return path
    }
}
