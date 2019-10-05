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
        
        PHPhotoLibrary.requestAuthorization({ status in
            guard status == .authorized else {
                return
            }
            PHPhotoLibrary.shared().performChanges({
                let changeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
                let objectPlaceholder = changeRequest.placeholderForCreatedAsset
                let albumRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: "Test")
                let enumeration: NSArray = [objectPlaceholder!]
                albumRequest.addAssets(enumeration)
            }, completionHandler: { isSaved, error in
                if let error = error {
                    NSLog("🛑 An error appeared while saving photo: " + error.localizedDescription)
                    return
                }
                if isSaved {
                    NSLog("✅ Successfully saved photo to library.")
                } else {
                    NSLog("wrong")
                }
                
            })
        })
        
//        UIImageWriteToSavedPhotosAlbum(
//            imageView.image!,
//            self,
//            #selector(image(_:didFinishSavingWithError:contextInfo:)), nil
//        )
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
