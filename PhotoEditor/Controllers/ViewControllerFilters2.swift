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
import Foundation

class ViewControllerFilters2: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var imageView: UIImageView!
    private var initialImage: UIImage!
    var filteredImage: UIImage?
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var tableView: UITableView!
    
    let indentifire = "My cell"

      
//MARK: - ARRAY OF FILTERS
    let filters: [PEFilter] = [
        PEFilter(name: "Normal", gpuFilter: GPUImageHSBFilter()),
        PEFilter(name: "Sepia", gpuFilter: GPUImageSepiaFilter()),
        PEFilter(name: "BoxBlur", gpuFilter: GPUImageBoxBlurFilter()),
        PEFilter(name: "Erosion", gpuFilter: GPUImageErosionFilter()),
        PEFilter(name: "Pixell", gpuFilter: GPUImagePixellateFilter()),
        PEFilter(name: "Swirl", gpuFilter: GPUImageSwirlFilter()),
        PEFilter(name: "Vignette", gpuFilter: GPUImageVignetteFilter()),
        PEFilter(name: "Sphere", gpuFilter: GPUImageGlassSphereFilter()),
        PEFilter(name: "Haze", gpuFilter: GPUImageHazeFilter()),
        PEFilter(name: "Hue", gpuFilter: GPUImageHueFilter()),
        PEFilter(name: "Toon", gpuFilter: GPUImageToonFilter()),

    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let filter = filteredImage {
            imageView.image = filter
        }

        createTable()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "✔", style: .plain, target: self, action: #selector(doneButtonDidPress))
        
        initialImage = imageView.image!
       
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    
    func printAlert(title: String, message: String, style: UIAlertController.Style) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: style)
            let actions = UIAlertAction(title: "OK", style: .default) { (action) in
                guard let image = self.imageView.image else {
                               NSLog("🛑 Missing UIImage!")
                               return
                           }
                self.saveImage(image)
            }
            
            let action = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                
            }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: indentifire, for: indexPath)
 
        let text = filters[indexPath.row].name
        cell.textLabel?.text = text
        cell.textLabel?.textAlignment = .center

        
        var savingImage = initialImage
        
        if savingImage?.cgImage == nil {
            let ciImage = initialImage.ciImage
            let cgImage = CIContext(options: nil).createCGImage(ciImage!, from: ciImage!.extent)
            savingImage = UIImage(cgImage: cgImage!)
        }
        
        let imageView = UIImageView(frame: CGRect(x: 10, y: 6, width: 88, height: 88))
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 44;// Corner radius should be half of the height and width.
        
        let filter = self.filters[indexPath.row].gpuFilter
        let filteredImage = filter.image(byFilteringImage: savingImage)
        imageView.image = filteredImage
        cell.addSubview(imageView)
        
        
        return cell
        
    }
    
    @objc func oneTapped(_ sender: Any?) {
        print("Tapped")
    }
       
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
     //MARK: - tabelView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filter = filters[indexPath.row].gpuFilter
        
        var initialImage = self.initialImage
        if initialImage?.cgImage == nil {
            let ciImage = self.initialImage.ciImage
            let cgImage = CIContext(options: nil).createCGImage(ciImage!, from: ciImage!.extent)
            initialImage = UIImage(cgImage: cgImage!)
        }
        let filteredImage = filter.image(byFilteringImage: initialImage!)
        self.imageView.image = filteredImage
        
    }
   
    //MARK: - Work with saving image
    
    @objc private func doneButtonDidPress() {
        guard let image = imageView.image else {
            NSLog("🛑 Missing UIImage!")
            return
        }
        saveImage(image)
    }

     //MARK: - SaveImage function saving image
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
    
     //MARK: - createFilter
    func createFilter(name: GPUImageFilter) -> UIImage{
        var filterImage = imageView.image
        
        if filterImage?.cgImage == nil {
            let ciImage = imageView.image?.ciImage
            let cgImage = CIContext(options: nil).createCGImage(ciImage!, from: ciImage!.extent)
            filterImage = UIImage(cgImage: cgImage!)
        }

        let filter = name
        let resultImage = filter.image(byFilteringImage: filterImage)
        return resultImage!
    }
}

