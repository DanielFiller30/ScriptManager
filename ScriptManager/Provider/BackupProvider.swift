//
//  BackupProvider.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 20.07.24.
//

import Resolver
import SwiftUI

class BackupProvider {
    @LazyInjected private var hintHandler: HintHandlerProtocol
    @LazyInjected private var modalHandler: ModalHandlerProtocol
    @LazyInjected private var storageHandler: StorageHandlerProtocol
    @LazyInjected private var alertHandler: AlertHandlerProtocol
    
    private let jsonProvider = JSONProvider()
    
    /// Export userdata as json to file
    func exportUserdata() {
        let folderChooserPoint = CGPoint(x: 0, y: 0)
        let folderChooserSize = CGSize(width: 500, height: 600)
        let folderChooserRectangle = CGRect(origin: folderChooserPoint, size: folderChooserSize)
        let folderPicker = NSOpenPanel(contentRect: folderChooserRectangle, styleMask: .utilityWindow, backing: .buffered, defer: true)
        
        folderPicker.canChooseDirectories = true
        folderPicker.canChooseFiles = false
        folderPicker.allowsMultipleSelection = false
        folderPicker.canDownloadUbiquitousContents = false
        folderPicker.canResolveUbiquitousConflicts = true
        
        folderPicker.begin { response in
            if response == .OK {
                let pickedFolder = folderPicker.url
                if let pickedFolder {
                    let fileName = pickedFolder.appendingPathComponent("ScriptManager_\(Date.now.toDateString()).json")
                    let userdataJSON = self.jsonProvider.convertToJson()
                    
                    if let userdataJSON {
                        do {
                            try userdataJSON.write(to: fileName, atomically: true, encoding: String.Encoding.utf8)
                            self.hintHandler.showHint(String(localized: "Data exported"), type: .success)
                        } catch {
                            self.hintHandler.showHint(String(localized: "Oops, something went wrong"), type: .error)
                            debugPrint(error)
                        }
                    } else {
                        self.hintHandler.showHint(String(localized: "Oops, something went wrong"), type: .error)
                    }
                }
            }
        }
    }
    
    /// Import userdata as json file and replace values of storage
    public func importUserdata() {
        let fileChooserPoint = CGPoint(x: 0, y: 0)
        let fileChooserSize = CGSize(width: 500, height: 600)
        let fileChooserRectangle = CGRect(origin: fileChooserPoint, size: fileChooserSize)
        let filePicker = NSOpenPanel(contentRect: fileChooserRectangle, styleMask: .utilityWindow, backing: .buffered, defer: true)
        
        filePicker.canChooseDirectories = false
        filePicker.canChooseFiles = true
        filePicker.allowsMultipleSelection = false
        filePicker.canDownloadUbiquitousContents = false
        filePicker.canResolveUbiquitousConflicts = true
        
        filePicker.begin { response in
            if response == .OK {
                let pickedFile = filePicker.url
                if let pickedFile {
                    do {
                        let data = try Data(contentsOf: pickedFile)
                        let userdataObject = self.jsonProvider.decodeToObject(data: data)
                        guard let userdataObject else {
                            self.hintHandler.showHint(String(localized: "Oops, something went wrong"), type: .error)
                            return
                        }
                        
                        self.storageHandler.scripts = userdataObject.scripts
                        self.storageHandler.times = userdataObject.times
                        self.storageHandler.tags = userdataObject.tags
                        self.storageHandler.settings = userdataObject.settings
                        
                        self.modalHandler.hideModal()
                        self.alertHandler.showAlert(
                            title: String(localized: "import-successfull"),
                            message: String(localized: "import-restart"),
                            btnTitle: String(localized: "restart"),
                            cancelVisible: false,
                            action: { NSApp.terminate(self) }
                        )
                    } catch {
                        self.hintHandler.showHint(String(localized: "Oops, something went wrong"), type: .error)
                        debugPrint(error)
                    }
                }
            }
        }
    }
}
