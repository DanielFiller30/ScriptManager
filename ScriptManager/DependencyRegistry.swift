//
//  DependencyRegistry.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 28.03.24.
//

import Foundation
import Resolver

// Register all dependencies for injection
extension Resolver: @retroactive ResolverRegistering {
    public static func registerAllServices() {
//        if ProcessInfo.processInfo.environment["IS_UNIT_TESTING"] == "1" {
//            register { StorageHandlerMock() as StorageHandlerProtocol }
//                .scope(.application)
//        } else {
//            register { StorageHandler() as StorageHandlerProtocol }
//                .scope(.application)
//        }
        
        register { StorageHandler() as StorageHandlerProtocol }
            .scope(.application)
        
        register { SettingsHandler() as SettingsHandlerProtocol }
            .scope(.application)
        
        register { ScriptHandler() as ScriptHandlerProtocol }
            .scope(.application)
        
        register { TagHandler() as TagHandlerProtocol }
            .scope(.application)
        
        register { AlertHandler() as AlertHandlerProtocol }
            .scope(.application)
        
        register { ModalHandler() as ModalHandlerProtocol }
            .scope(.application)
        
        register { HintHandler() as HintHandlerProtocol }
            .scope(.application)
        
        register { CronJobHandler() as CronJobHandlerProtocol }
            .scope(.application)
        
        register { NotificationHandler() as NotificationHandlerProtocol }
    }
}
