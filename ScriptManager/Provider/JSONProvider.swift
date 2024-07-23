//
//  JSONProvider.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 20.07.24.
//

import Foundation
import Resolver

class JSONProvider {
    @LazyInjected var storageHandler: StorageHandlerProtocol
    
    /// Convert saved userdata to json string
    ///  - Returns: json-object as `String`
    func convertToJson() -> String? {
        let savedUserdata = Userdata(
            scripts: storageHandler.scripts,
            times: storageHandler.times,
            tags: storageHandler.tags,
            settings: storageHandler.settings
        )
        
        let jsonEncoder = JSONEncoder()
        
        do {
            let jsonData = try jsonEncoder.encode(savedUserdata)
            guard let json = String(data: jsonData, encoding: String.Encoding.utf8) else {
                return nil
            }
            
            return json
        } catch {
            debugPrint(error)
            return nil
        }
    }
    
    /// Decode json string to userdata model
    ///  - Parameter data: The imported data of json file
    ///  - Returns: The userdata object
    func decodeToObject(data: Data) -> Userdata? {
        do {
            let jsonDecoder = JSONDecoder()
            let userdata = try jsonDecoder.decode(Userdata.self, from: data)
            return userdata
        } catch {
            debugPrint(error)
            return nil
        }
    }
}
