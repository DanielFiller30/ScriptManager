//
//  ColorHandler.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.04.23.
//

import Foundation
import SwiftUI

typealias PlatformColor = NSColor
extension Color {
    init(platformColor: PlatformColor) {
        self.init(nsColor: platformColor)
    }
}

class ColorConverter {
    /// Encode color to data to save the value to UserDefaults
    /// - Parameter color: Color to convert
    /// - Returns: Data object of passed color
    static func encodeColor(color: Color) throws -> Data {
        let platformColor = PlatformColor(color)
        return try NSKeyedArchiver.archivedData(
            withRootObject: platformColor,
            requiringSecureCoding: true
        )
    }

    /// Decode data object to color
    /// - Parameter data: Data object to decode to color
    /// - Returns: Decoded color object of passed data
    static func decodeColor(from data: Data) throws -> Color {
        guard let platformColor = try NSKeyedUnarchiver.unarchivedObject(ofClass: PlatformColor.self, from: data)
            else {
                throw DecodingError.wrongType
            }
        return Color(platformColor: platformColor)
    }

    /// Default encoced color object as `Data`
    static var defaultEncodedColor: Data {
        do {
            return try encodeColor(color: AppColor.Primary)
        } catch {
            debugPrint(error)
            return Data()
        }
    }
}

enum DecodingError: Error {
    case wrongType
}
