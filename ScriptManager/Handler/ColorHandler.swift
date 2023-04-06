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

class ColorHandler: ColorHandlerProtocol {
    static func encodeColor(color: Color) throws -> Data {
        let platformColor = PlatformColor(color)
        return try NSKeyedArchiver.archivedData(
            withRootObject: platformColor,
            requiringSecureCoding: true
        )
    }

    static func decodeColor(from data: Data) throws -> Color {
        guard let platformColor = try NSKeyedUnarchiver
                .unarchiveTopLevelObjectWithData(data) as? PlatformColor
            else {
                throw DecodingError.wrongType
            }
        return Color(platformColor: platformColor)
    }

    static var defaultEncodedColor: Data {
        do {
            return try encodeColor(color: AppColor.Primary)
        } catch {
            debugPrint(error)
            return Data()
        }
    }
    
    static func getDecodedColor(data: Data) -> Color {
        do {
            return try ColorHandler.decodeColor(from: data)
        } catch {
            return AppColor.Primary
        }
    }
}

enum DecodingError: Error {
    case wrongType
}
