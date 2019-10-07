//
//  ViewControllerFilters2.swift
//  PhotoEditor
//
//  Created by Дарья Косякова on 9/23/19.
//  Copyright © 2019 Дарья Косякова. All rights reserved.
//

import UIKit
import Photos
import GPUImage

class ViewControllerFilters2: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var imageView: UIImageView!
    var filteredImage: UIImage?
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var tableView: UITableView!
    
    let indentifire = "My cell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let filter = filteredImage {
            imageView.image = filter
        }
        
        createTable()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "✔", style: .plain, target: self, action: #selector(doneButtonDidPress))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    // MARK: - createTable
    func createTable() {
           tableView.register(UITableViewCell.self, forCellReuseIdentifier: indentifire)
           
           self.tableView.delegate = self
           self.tableView.dataSource = self
           
       }
    
    
     // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 10
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: indentifire, for: indexPath)
        //cell.textLabel?.text = "section = \(indexPath.section) cell = \(indexPath.row)"
        
        let image = "11.jpg"
        let image1 = UIImage(named: image)
    
        
        let imageView = UIImageView(frame: CGRect(x: 10, y: 6, width: 88, height: 88))
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 44;// Corner radius should be half of the height and width.
        imageView.image = image1
        cell.addSubview(imageView)
        
        return cell
        
    }
    
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    
    
    //MARK: - Work with saving image
    
    @objc private func doneButtonDidPress() {
        guard let image = imageView.image else {
            NSLog("🛑 Missing UIImage!")
            return
        }
        saveImage(image)
    }

    
    private func saveImage(_ image: UIImage) {
        var savingImage = image
        if savingImage.cgImage == nil {
            guard let ciImage = image.ciImage, let cgImage = CIContext(options: nil).createCGImage(ciImage, from: ciImage.extent) else {
                NSLog("🛑 Failed to make CGImage from CIImage")
                return
            }
            savingImage = UIImage(cgImage: cgImage)
        }
        guard let imageData = savingImage.jpegData(compressionQuality: 1.0) else {
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
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            return
        }
        NSLog("✅ Successfully saved photo to library.")
        let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
           ac.addAction(UIAlertAction(title: "OK", style: .default))
           present(ac, animated: true)
        
    }
}



