//
//  ModalHandlerTests.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 30.07.24.
//

@testable import ScriptManager

import Resolver
import Testing

final class ModalHandlerTests {
    @LazyInjected private var sut: ModalHandlerProtocol
    
    let testTitle = "a"
    let testMessage = "b"
    let testBtnTitle = "c"
    let testCancelVisible = false
    
    @Test("Check modal visible") func showModalTest() {
        sut.showModal(.INFO)
        #expect(sut.modalVisible == true)
    }
    
    @Test("Check modal hidden") func hideModalTest() {
        sut.hideModal()
        #expect(sut.modalVisible == false)
    }
    
    @Test("Check modal type") func modalTypeTest() {
        sut.showModal(.INFO)
        #expect(sut.type == .INFO)
    }
}
