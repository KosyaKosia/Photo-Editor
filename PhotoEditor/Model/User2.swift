//
//  User2.swift
//  PhotoEditor
//
//  Created by Дарья Косякова on 3/28/20.
//  Copyright © 2020 Дарья Косякова. All rights reserved.
//

import Foundation

class User2 {
    
    private let acc: Account
    
    init(acc: Account) {
        self.acc = acc
    }
    
    func getDev() {
        acc.getDev()
    }
    
    func getUser() {
        acc.getUser()
    }
}
