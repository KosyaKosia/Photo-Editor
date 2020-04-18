//
//  User.swift
//  PhotoEditor
//
//  Created by Дарья Косякова on 3/14/20.
//  Copyright © 2020 Дарья Косякова. All rights reserved.
//

import Foundation

class User {
    
    let array: [String]
    
    init() {
        array = ["Client", "Developer"]
    }
    
    
    func getUser(index: Int) -> String {
        if index == 0 {
            return array[0]
        } else if index == 1{
            return array[1]
        } else {
            return ("Out of range")
        }
    }
}
