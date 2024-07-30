//
//  HintHandlerTests.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 30.07.24.
//

@testable import ScriptManager

import Resolver
import Testing

@Suite(.serialized) final class HintHandlerTests {
    @LazyInjected private var sut: HintHandlerProtocol
    
    let testMessage = "a"
    
    @Test("Check hint visible") func showHintTest() {
        sut.showHint(testMessage, type: .success)
        #expect(sut.hintVisible == true)
    }
    
    @Test("Check hint hidden") func hideHintTest() {
        sut.hideHint()
        #expect(sut.hintVisible == false)
    }
    
    @Test("Check hint values") func hintValuesTest() {
        sut.showHint(testMessage, type: .error)
        #expect(sut.hintText == testMessage)
        #expect(sut.hintType == .error)
    }
}
