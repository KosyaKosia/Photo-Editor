//
//  DeveloperAccTest.swift
//  PhotoEditorTests
//
//  Created by Дарья Косякова on 3/16/20.
//  Copyright © 2020 Дарья Косякова. All rights reserved.
//

import XCTest
@testable import PhotoEditor
class DeveloperAccTest: XCTestCase {

    func testInit() {
        let devAcc = DeveloperAccount()
        XCTAssertEqual(devAcc.developerAccounts.count, 2)
    }
    
    func testAddDeveloper_AddToArray() {
        let devAcc = DeveloperAccount()
        devAcc.developerAccounts.removeAll()
        devAcc.addDeveloper()
        
        XCTAssertEqual(devAcc.developerAccounts.count, 2)
    }
    
    func testAddDeveloper_WithoutWorkingIF() {
        let devAcc = DeveloperAccount()
        devAcc.developerAccounts.removeAll()
        devAcc.passArray.removeAll()
        devAcc.addDeveloper()
        
        XCTAssertNotEqual(devAcc.developerAccounts.count, 2)
        XCTAssertEqual(devAcc.developerAccounts.count, 0)
    }
    
    func testAddDeveloper_WithoutWorkingFOR() {
        let devAcc = DeveloperAccount()
        devAcc.developerAccounts.removeAll()
        devAcc.loginArray.removeAll()
        devAcc.addDeveloper()
        
        XCTAssertNotEqual(devAcc.developerAccounts.count, 2)
        XCTAssertEqual(devAcc.developerAccounts.count, 0)
    }
    
    func 
}
