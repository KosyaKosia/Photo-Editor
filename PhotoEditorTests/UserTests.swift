//
//  UserTests.swift
//  PhotoEditorTests
//
//  Created by Дарья Косякова on 3/14/20.
//  Copyright © 2020 Дарья Косякова. All rights reserved.
//

import XCTest

@testable import PhotoEditor

class UserTests: XCTestCase {
    
    func testInit_GetArrayCount() {
        let user = User()
        XCTAssertEqual(user.array.count, 2)
    }
    
    func testGetUser_OutOfRange() {
        let user = User()
        XCTAssertEqual(user.getUser(index: 100), "Out of range")
    }
    
    func testGetUser_GetClient() {
        let user = User()
        XCTAssertNotEqual(user.getUser(index: 0), "Out of range")
        XCTAssertEqual(user.getUser(index: 0), "Client")

    }
    
    func testGetUser_GetDeveloper() {
        let user = User()
        XCTAssertNotEqual(user.getUser(index: 1), "Out of range")
        XCTAssertEqual(user.getUser(index: 1), "Developer")

    }
}
