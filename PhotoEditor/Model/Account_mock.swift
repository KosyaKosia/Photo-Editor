//
//  User_mock.swift
//  PhotoEditorTests
//
//  Created by Дарья Косякова on 3/28/20.
//  Copyright © 2020 Дарья Косякова. All rights reserved.
//

import Foundation

class Account_mock: Account {
    
    var accCount = 0
    
    override func getDev() {
        accCount += 1
    }
    
    override func getUser() {
        accCount += 1
    }
    
}

