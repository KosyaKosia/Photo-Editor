//
//  ViewController.swift
//  PhotoEditor
//
//  Created by Дарья Косякова on 9/19/19.
//  Copyright © 2019 Дарья Косякова. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if checkImageView(imageView: self.imageView) == false {
            self.nextButton.isEnabled = false
            self.nextButton.isHidden = true
        } else {
            self.nextButton.isEnabled = true
            self.nextButton.isHidden = false
        }

        imagePicker.delegate = self
       
    }

    @IBAction func pickImage(_ sender: Any) {
    
            imagePicker.allowsEditing = true

            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func nextButton(_ sender: Any) {
        
       
    }
    
    func checkImageView(imageView: UIImageView) -> Bool {
        if imageView.image == nil {
            print("isnt available")
            return false
        } else {
            print("is available")
            
            return true
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        imageView.image = image
        
        self.imagePicker.dismiss(animated: true, completion: nil)
        
        
        if checkImageView(imageView: self.imageView) == false {
            self.nextButton.isEnabled = false
            self.nextButton.isHidden = true
        } else {
            self.nextButton.isEnabled = true
            self.nextButton.isHidden = false
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextController = segue.destination as? ViewControllerFilters
        nextController?.image = self.imageView.image
    }
}

