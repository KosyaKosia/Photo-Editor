//
//  ViewController22.swift
//  PhotoEditor
//
//  Created by Дарья Косякова on 3/6/20.
//  Copyright © 2020 Дарья Косякова. All rights reserved.
//

import UIKit

protocol SecondViewControllerDelegate {
    func fillTheLabelWith(info:String)
}

class ViewController22: UIViewController {

    
    var delegate: SecondViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "11.jpg")!)
    }
   
    @IBAction func changeStyle(_ sender: Any) {
        printAlert(title: "Change style", message: "Are you shure?", style: .alert)
    }
    
    
    func printAlert(title: String, message: String, style: UIAlertController.Style) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: style)
            let actions = UIAlertAction(title: "OK", style: .default) { (action) in
    
                self.view.backgroundColor = UIColor.lightGray
            }
            
            let action = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                
            }
            
            alert.addAction(actions)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }

    
    
}
