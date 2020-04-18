//
//  DeveloperAcc2.swift
//  PhotoEditor
//
//  Created by Дарья Косякова on 3/28/20.
//  Copyright © 2020 Дарья Косякова. All rights reserved.
//

import Foundation

class DeveloperAcc2 {
    private var user = User()
    
    init(user: User) {
        self.user = user
    }
    
    func getUserDev() {
        user.getUser(index: 0)
    }
    func getUserClient() {
        user.getUser(index: 1)
    }
}
