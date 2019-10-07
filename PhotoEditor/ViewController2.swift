//
//  ViewController2.swift
//  PhotoEditor
//
//  Created by Дарья Косякова on 9/20/19.
//  Copyright © 2019 Дарья Косякова. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var fromLibrary: UIButton!
    @IBOutlet weak var takePhoto: UIButton!
    
    override func viewDidLoad() {
        
        fromLibrary.layer.cornerRadius = 23
        takePhoto.layer.cornerRadius = 23
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "11.jpg")!)
        
        super.viewDidLoad()
    }

    @IBAction func selectFromLibruary(_ sender: Any) {
        // TODO:
    }

    @IBAction func takePhoto(_ sender: Any) {
        // TODO:
    }
}
