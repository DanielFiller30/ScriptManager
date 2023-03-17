//
//  ColorHandler.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import Foundation
import SwiftUI

struct AppColor {
    static let Dark = Color("Dark")
    static let Light = Color("Light")
    static let Success = Color("Success")
    static let Danger = Color("Danger")
    static let Creme = Color("Creme")
    static let Background = Color("Background")
    static let AppBg = Color("AppBg")
    static let Primary = Color("Primary")
}

typealias PlatformColor = NSColor
extension Color {
    init(platformColor: PlatformColor) {
        self.init(nsColor: platformColor)
    }
}

public func encodeColor(color: Color) throws -> Data {
    let platformColor = PlatformColor(color)
    return try NSKeyedArchiver.archivedData(
        withRootObject: platformColor,
        requiringSecureCoding: true
    )
}

public func decodeColor(from data: Data) throws -> Color {
    guard let platformColor = try NSKeyedUnarchiver
            .unarchiveTopLevelObjectWithData(data) as? PlatformColor
        else {
            throw DecodingError.wrongType
        }
    return Color(platformColor: platformColor)
}

enum DecodingError: Error {
    case wrongType
}
