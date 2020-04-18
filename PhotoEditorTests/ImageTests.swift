//
//  ImageTests.swift
//  PhotoEditorTests
//
//  Created by Дарья Косякова on 3/26/20.
//  Copyright © 2020 Дарья Косякова. All rights reserved.
//

import XCTest
import UIKit

@testable import PhotoEditor

class ImageTests: XCTestCase {
    
    func testIsImageAvaiable_True() {
        let vc = ViewController()
        let image = UIImageView()
        image.image = UIImage.remove
        
        XCTAssertEqual(true, vc.isImageAvailable(imageView: image))
        
    }
    
     func testIsImageAvaiable_False() {
           let vc = ViewController()
           let image = UIImageView()
           image.image = nil
           
           XCTAssertNotEqual(true, vc.isImageAvailable(imageView: image))
           
       }
}
