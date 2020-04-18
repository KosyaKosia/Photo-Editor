//
//  Account.swift
//  PhotoEditor
//
//  Created by Дарья Косякова on 3/28/20.
//  Copyright © 2020 Дарья Косякова. All rights reserved.
//

import Foundation

class Account {
    
    private var acc: UserEnum = .Developer
    
    func getDev() {
        acc = .Developer
    }
    
    func getUser() {
        acc = .Client
    }
}


