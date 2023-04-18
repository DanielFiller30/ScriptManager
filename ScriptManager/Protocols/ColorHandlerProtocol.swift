//
//  ColorHandlerProtocol.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.04.23.
//

import Foundation
import SwiftUI

protocol ColorHandlerProtocol {
    static func encodeColor(color: Color) throws -> Data
    static func decodeColor(from data: Data) throws -> Color
    static var defaultEncodedColor: Data { get }
}
