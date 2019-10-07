import UIKit

class ViewController3: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var takePhoto: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        
        let hasImage = isImageAvailable(imageView: imageView)
        nextButton.isEnabled = hasImage
        nextButton.isHidden = !hasImage
        
        nextButton.layer.cornerRadius = 15
        takePhoto.layer.cornerRadius = 15

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButton(_ sender: Any) {
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        
        imagePicker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)}
        else {
            print("Camera isnt available")
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextController = segue.destination as? ViewControllerFilters
        nextController?.image = self.imageView.image
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        imageView.image = image
        
        self.imagePicker.dismiss(animated: true, completion: nil)
        
        let hasImage = isImageAvailable(imageView: imageView)
               nextButton.isEnabled = hasImage
               nextButton.isHidden = !hasImage
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}

