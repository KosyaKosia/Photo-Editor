//
//  ViewControllerFilters2.swift
//  PhotoEditor
//
//  Created by Дарья Косякова on 9/23/19.
//  Copyright © 2019 Дарья Косякова. All rights reserved.
//

import UIKit
import Photos

class ViewControllerFilters2: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var filteredImage: UIImage?
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = filteredImage!
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let image = imageView.image!

        saveImage(image)
    }

    private func saveImage(_ image: UIImage) {
        guard let imageData = image.pngData() else {
            NSLog("🛑 Failed to make data from image")
            return
        }
        guard let compressedImage = UIImage(data: imageData) else {
            NSLog("🛑 Failed to make image from data")
            return
        }
        UIImageWriteToSavedPhotosAlbum(
            compressedImage,
            self,
            #selector(image(_:didFinishSavingWithError:contextInfo:)),
            nil
        )
    }
    
    @objc private func image(_ image: UIImage,
                             didFinishSavingWithError error: Error?,
                             contextInfo: UnsafeRawPointer) {
        if let error = error {
            NSLog("🛑 An error appeared while saving photo: " + error.localizedDescription)
            return
        }
        NSLog("✅ Successfully saved photo to library.")
    }
}
