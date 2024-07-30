//
//  AlertHandlerTests.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 30.07.24.
//

@testable import ScriptManager

import Resolver
import Testing

@Suite(.serialized) final class AlertHandlerTests {
    @LazyInjected private var sut: AlertHandlerProtocol
    
    let testTitle = "a"
    let testMessage = "b"
    let testBtnTitle = "c"
    let testCancelVisible = false
    
    @Test("Check alert visible") func showAlertTest() {
        sut.showAlert(title: testTitle, message: testMessage, btnTitle: testBtnTitle, cancelVisible: testCancelVisible, action: {})
        #expect(sut.alertVisible == true)
    }
    
    @Test("Check alert hidden") func hideAlertTest() {
        sut.hideAlert()
        #expect(sut.alertVisible == false)
    }
    
    @Test("Check alert values") func alertValuesTest() {
        sut.showAlert(title: testTitle, message: testMessage, btnTitle: testBtnTitle, cancelVisible: testCancelVisible, action: {})
        #expect(sut.title == testTitle)
        #expect(sut.message == testMessage)
        #expect(sut.btnTitle == testBtnTitle)
        #expect(sut.cancelVisible == testCancelVisible)
    }
}
