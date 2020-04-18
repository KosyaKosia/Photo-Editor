//
//  User_mock_test.swift
//  PhotoEditorTests
//
//  Created by Дарья Косякова on 3/28/20.
//  Copyright © 2020 Дарья Косякова. All rights reserved.
//

import XCTest

@testable import PhotoEditor

class testUser_mock: XCTestCase {
    
    func testGetUser_User() {
        let accMock = Account_mock()
        let user = User2(acc: accMock)
        
        user.getUser()
        
        XCTAssert((accMock.accCount == 1), "User")
    }
    
    func testGetDeveloper_Dev() {
           let accMock = Account_mock()
           let dev = User2(acc: accMock)
           
           dev.getDev()
           
           XCTAssert((accMock.accCount == 1), "Developer")
       }

}
