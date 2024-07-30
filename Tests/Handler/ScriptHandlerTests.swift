//
//  ScriptHandlerTests.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 30.07.24.
//

@testable import ScriptManager

import Testing
import Resolver
import Foundation

final class ScriptHandlerTests {
    @LazyInjected private var sut: ScriptHandlerProtocol
    @LazyInjected private var storageHandler: StorageHandlerProtocol
    
    var testScript = Script(name: "Test", icon: "xmark", command: "echo 'test'", success: .ready, finished: false)
    
    init() {
        sut.scripts.append(testScript)
    }
    
    @Test("Valid script command") func testValidScript() async {
        let expectedResult = await sut.runScript(testScript, test: true)
        #expect(expectedResult.state == .successfull)
    }
    
    @Test("Invalid script command") func testInvalidScript() async {
        testScript.id = UUID()
        testScript.command = "abcdefg"
        sut.scripts.append(testScript)
        
        let expectedResult = await sut.runScript(testScript, test: true)
        
        #expect(expectedResult.state == .failed)
    }
    
    @Test("Interrupting script") func testInterrupting() async {
        let id = UUID()
        testScript.id = id
        testScript.command = "sleep 10; echo 'Hello World'"
        sut.scripts.append(testScript)
                        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.sut.interruptRunningProcess(scriptId: id)
        }
        
        let expectedResult = await self.sut.runScript(self.testScript, test: true)
        #expect(expectedResult.state == .interrupted)
    }
}
