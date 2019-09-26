//
//  ViewControllerFilters.swift
//  PhotoEditor
//
//  Created by Дарья Косякова on 9/20/19.
//  Copyright © 2019 Дарья Косякова. All rights reserved.
//

import UIKit

class ViewControllerFilters: UIViewController {

    //@IBOutlet weak var sepiaLabelValue: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage? = nil
    var filter = CIFilter(name: "CISepiaTone")
    var filteredImage: CIImage? = nil
    
    
    @IBOutlet weak var slider: UISlider!
    let context = CIContext()
    
    @IBOutlet weak var slider2: UISlider!
    @IBOutlet weak var slider3: UISlider!
  
    @IBOutlet weak var slider4: UISlider!
   
    
    let colorControlsFilter = CIFilter(name: "CIColorControls")!
    let sepiaFilter = CIFilter(name:"CISepiaTone")!
    let sharp = CIFilter(name: "CISharpenLuminance")!
    
    var originalCIImage: CIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.originalCIImage = CIImage(image: self.image!)
        self.imageView.image = image
        self.slider.addTarget(self, action: #selector(sliderValueDidChange(sender:)), for: .valueChanged )
        self.slider2.addTarget(self, action: #selector(sliderValueDidChange(sender:)), for: .valueChanged)
        self.slider3.addTarget(self, action: #selector(sliderValueDidChange(sender:)), for: .valueChanged)
        self.slider4.addTarget(self, action: #selector(sliderValueDidChange(sender:)), for: .valueChanged)
   
         self.updateImage()
    }
    
    
    @objc func sliderValueDidChange(sender: UISlider!) {
        
        switch sender.tag {
        case 0:
            let value = sender.value
            //self.sepiaLabelValue.text = String(Int(value))
            self.sharp.setValue(value, forKey: kCIInputSharpnessKey)
        case 1:
            let value = sender.value
            //self.brightnessValue.text = String(Int(value))
            self.colorControlsFilter.setValue(value, forKey: kCIInputBrightnessKey)
        case 2:
            let value = sender.value
            //self.contrastLabel.text = String(Int(value))
            self.colorControlsFilter.setValue(value, forKey: kCIInputContrastKey)
        case 3:
            let value = sender.value
            //self.saturationValue.text = String(Int(value))
            self.colorControlsFilter.setValue(value, forKey: kCIInputSaturationKey)
        default:
            print("no such elements")
        }
        
      self.updateImage()
    }
    
    func updateImage() {
            DispatchQueue.main.async {
//                let originalCIImage = CIImage(image: self.image!)
                self.colorControlsFilter.setValue(self.originalCIImage, forKey: kCIInputImageKey)
                self.sharp.setValue(self.colorControlsFilter.outputImage, forKey: kCIInputImageKey)
                self.imageView.image = UIImage(ciImage: self.sharp.outputImage!)
        }
    }
    
//    @objc func sliderValueDidChange(sender: UISlider!) {
//
//        switch sender.tag {
//        case 0:
//            let originalCIImage = CIImage(image: self.image!)
//            let value = sender.value
//            self.sepiaLabelValue.text = String(Int(value*100))
//            if  let sepiaCIImage = sepiaFilter(originalCIImage!, intensity: Double(value)) {
//                filteredImage = sepiaCIImage
//                self.imageView.image = UIImage(ciImage: sepiaCIImage)
//            }
//        case 1:
//            let originalCIImage = CIImage(image: self.image!)
//            let value = sender.value
//            self.brightnessValue.text = String(Int(value*100))
//            if let brightnessCIImage = brightnessFilter(originalCIImage!, intensity: Double(value)) {
//                filteredImage = brightnessCIImage
//                self.imageView.image = UIImage(ciImage:brightnessCIImage)
//            }
//        case 2:
//            let originalCIImage = CIImage(image: self.image!)
//            let value = sender.value
//            self.contrastLabel.text = String(Int(value*100))
//            if let contrastCIImage = contrastFilter(originalCIImage!, intensity: Double(value)){
//                filteredImage = contrastCIImage
//                self.imageView.image = UIImage(ciImage:contrastCIImage)
//            }
//
//        case 3:
//            let originalCIImage = CIImage(image: self.image!)
//            let value = sender.value
//            self.saturationValue.text = String(Int(value*100))
//            if let saturationCIImage = saturationFilter(originalCIImage!, intensity: Double(value)) {
//                filteredImage = saturationCIImage
//                self.imageView.image = UIImage(ciImage:saturationCIImage)
//            }
//
//        default:
//            print("No such tags")
//        }


    
//    func sepiaFilter(_ input: CIImage, intensity: Double) -> CIImage?
//    {
//        let sepiaFilter = CIFilter(name:"CISepiaTone")
//        sepiaFilter?.setValue(input, forKey: kCIInputImageKey)
//        sepiaFilter?.setValue(intensity, forKey: kCIInputIntensityKey)
//        return sepiaFilter?.outputImage
//    }
//    
//    func brightnessFilter(_ input: CIImage, intensity: Double) -> CIImage? {
//        let brightnessFilter = CIFilter(name: "CIColorControls")
//        brightnessFilter?.setValue(input, forKey: kCIInputImageKey)
//        brightnessFilter?.setValue(intensity, forKey: kCIInputBrightnessKey)
//        return brightnessFilter?.outputImage
//    }
//    
//    func contrastFilter(_ input: CIImage, intensity: Double) -> CIImage? {
//        let contrastFilter = CIFilter(name: "CIColorControls")
//        contrastFilter?.setValue(input, forKey: kCIInputImageKey)
//        contrastFilter?.setValue(intensity, forKey: kCIInputContrastKey)
//        return contrastFilter?.outputImage
//    }
//    
//    func saturationFilter(_ input: CIImage, intensity: Double) -> CIImage? {
//        let saturationFilter = CIFilter(name: "CIColorControls")
//        saturationFilter?.setValue(input, forKey: kCIInputImageKey)
//        saturationFilter?.setValue(intensity, forKey: kCIInputSaturationKey)
//        return saturationFilter?.outputImage
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextController = segue.destination as? ViewControllerFilters2
        nextController?.filteredImage = self.imageView.image!
    }
}


