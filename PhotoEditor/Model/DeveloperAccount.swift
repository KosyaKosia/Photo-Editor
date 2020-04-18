//
//  DeveloperAccount.swift
//  PhotoEditor
//
//  Created by Дарья Косякова on 3/14/20.
//  Copyright © 2020 Дарья Косякова. All rights reserved.
//

import Foundation

class DeveloperAccount {
    
    var loginArray = ["kosya", "dasha"]
    var passArray = ["123", "321"]
    var developerAccounts = [Developer]()
    
    func addDeveloper() {
        for index in 0 ..< loginArray.count {
            if loginArray.count == passArray.count {
                let someDev = Developer(pass: passArray[index], login: loginArray[index])
                developerAccounts.append(someDev)
            }
        }
    }
    
    init() {
        self.addDeveloper()
    }
}
