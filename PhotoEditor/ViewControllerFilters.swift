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
    var image: UIImage?
    var filter = CIFilter(name: "CISepiaTone")
    var filteredImage: CIImage? = nil
    

    let context = CIContext()

    @IBOutlet weak var slider: CustomSlider!
    @IBOutlet weak var slider2: CustomSlider!
    @IBOutlet weak var slider3: CustomSlider!
    @IBOutlet weak var slider4: CustomSlider!
    
    
    let colorControlsFilter = CIFilter(name: "CIColorControls")!
    let sepiaFilter = CIFilter(name:"CISepiaTone")!
    let sharp = CIFilter(name: "CISharpenLuminance")!
    
    var originalCIImage: CIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        originalCIImage = CIImage(image: image!)
        imageView.image = image

        slider.addTarget(self, action: #selector(sliderValueDidChange(sender:)), for: .valueChanged)
        slider2.addTarget(self, action: #selector(sliderValueDidChange(sender:)), for: .valueChanged)
        slider3.addTarget(self, action: #selector(sliderValueDidChange(sender:)), for: .valueChanged)
        slider4.addTarget(self, action: #selector(sliderValueDidChange(sender:)), for: .valueChanged)

         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "✔", style: .plain, target: self, action: #selector(addTapped))
        
        updateImage()
    }
    
    @objc func addTapped() {

        let filterTwoController = self.storyboard?.instantiateViewController(withIdentifier: "filter2") as! ViewControllerFilters2
        filterTwoController.filteredImage = imageView.image!
        self.navigationController?.pushViewController(filterTwoController, animated: true)
    }
    
    @objc func sliderValueDidChange(sender: UISlider!) {
        switch sender.tag {
        case 0:
            let value = sender.value
            //self.sepiaLabelValue.text = String(Int(value))
            sharp.setValue(value, forKey: kCIInputSharpnessKey)
        case 1:
            let value = sender.value
            //self.brightnessValue.text = String(Int(value))
            colorControlsFilter.setValue(value, forKey: kCIInputBrightnessKey)
        case 2:
            let value = sender.value
            //self.contrastLabel.text = String(Int(value))
            colorControlsFilter.setValue(value, forKey: kCIInputContrastKey)
        case 3:
            let value = sender.value
            //self.saturationValue.text = String(Int(value))
            colorControlsFilter.setValue(value, forKey: kCIInputSaturationKey)
        default:
            print("no such elements")
        }
        
        updateImage()
    }
    
    func updateImage() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            //                let originalCIImage = CIImage(image: self.image!)
            self.colorControlsFilter.setValue(self.originalCIImage, forKey: kCIInputImageKey)
            self.sharp.setValue(self.colorControlsFilter.outputImage, forKey: kCIInputImageKey)
            self.imageView.image = UIImage(ciImage: self.sharp.outputImage!)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextController = segue.destination as? ViewControllerFilters2
        nextController?.filteredImage = imageView.image!
    }
}

class CustomSlider: UISlider {

     override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var bounds: CGRect = self.bounds
        bounds = bounds.insetBy(dx: -40, dy: -40)
        return bounds.contains(point)
     }
}

//class CustomSlider: UISlider {
//
///*
//// Only override draw() if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//override func draw(_ rect: CGRect) {
//   //Drawing code
//}
//*/
//// Increase slider height
//   override func trackRect(forBounds bounds: CGRect) -> CGRect {
//    let customBounds: CGRect = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 5.0))
//    return customBounds
//}
//
//
//
//override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
//    return super.thumbRect(
//        forBounds: bounds, trackRect: rect, value: value)
//
//
//}
//
//// Increase Thumb hot spot clickable area
//override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//    var bounds: CGRect = self.bounds
//    bounds = bounds.insetBy(dx: -10, dy: -10);
//    return bounds.contains(point);
//
//}
//
//override func awakeFromNib() {
//   //Configure Volume slider
//    let thumbImageNormal = UIImage.init(named:"thumb")
//    self.setThumbImage(thumbImageNormal, for: .normal)
//
//    super.awakeFromNib()
//}

//}
