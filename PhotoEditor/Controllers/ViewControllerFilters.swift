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
    
     //MARK: - addTapped - func for navbar
    
    @objc func addTapped() {
        
        printAlert(title: "Next Screen", message: "Are you sure?", style: .alert)

       
    }
    
    //MARK: - SliderValueDidChange
    
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
    
     //MARK: - updateImage
    func updateImage() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
           
            self.colorControlsFilter.setValue(self.originalCIImage, forKey: kCIInputImageKey)
            self.sharp.setValue(self.colorControlsFilter.outputImage, forKey: kCIInputImageKey)
            self.imageView.image = UIImage(ciImage: self.sharp.outputImage!)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextController = segue.destination as? ViewControllerFilters2
        nextController?.filteredImage = imageView.image!
    }
    
    func printAlert(title: String, message: String, style: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let actions = UIAlertAction(title: "OK", style: .default) { (action) in

            let filterTwoController = self.storyboard?.instantiateViewController(withIdentifier: "filter2") as! ViewControllerFilters2
            filterTwoController.filteredImage = self.imageView.image!
                   self.navigationController?.pushViewController(filterTwoController, animated: true)
        }
        
        let action = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        
        
        alert.addAction(actions)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

 //MARK: - CustomSlider
class CustomSlider: UISlider {

     override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var bounds: CGRect = self.bounds
        bounds = bounds.insetBy(dx: -20, dy: -20)
        return bounds.contains(point)
     }
}

