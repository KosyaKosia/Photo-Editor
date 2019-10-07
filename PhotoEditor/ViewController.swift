//
//  ViewController.swift
//  PhotoEditor
//
//  Created by Дарья Косякова on 9/19/19.
//  Copyright © 2019 Дарья Косякова. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var pickImage: UIButton!
    
    let imagePicker = UIImagePickerController()
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hasImage = isImageAvailable(imageView: imageView)
        nextButton.isEnabled = hasImage
        nextButton.isHidden = !hasImage
        
        nextButton.layer.cornerRadius = 15
        pickImage.layer.cornerRadius = 15
      
        imagePicker.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextController = segue.destination as? ViewControllerFilters
        nextController?.image = self.imageView.image
    }

    @IBAction func pickImage(_ sender: Any) {
        imagePicker.allowsEditing = true

        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        // TODO: Implement method
    }
    
    func isImageAvailable(imageView: UIImageView) -> Bool {
        if imageView.image == nil {
            print("isnt available")
            return false
        } else {
            print("is available")
            
            return true
        }
    }
}

// MARK: - UIImagePickerControllerDelegate implementation

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        imageView.image = image

        imagePicker.dismiss(animated: true, completion: nil)

        let hasImage = isImageAvailable(imageView: imageView)
        nextButton.isEnabled = hasImage
        nextButton.isHidden = !hasImage
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UINavigationControllerDelegate implementation

extension ViewController: UINavigationControllerDelegate { }
