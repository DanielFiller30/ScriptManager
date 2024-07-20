//
//  BackupViewModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 20.07.24.
//

import Resolver

class BackupViewModel {
    @LazyInjected private var modalHandler: ModalHandlerProtocol
    private let backupProvider = BackupProvider()
    
    func exportUserdate() {
        backupProvider.exportUserdata()
    }
    
    func importUserdate() {
        backupProvider.importUserdata()
//        modalHandler.hideModal()
    }
}
