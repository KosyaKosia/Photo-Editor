//
//  ViewControllerFirst.swift
//  
//
//  Created by Дарья Косякова on 2/21/20.
//


import UIKit

class ViewController: UIViewController {

    let array = ["Client", "Developer"]
    var flag = false
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
    }

    // Кнопка перехода на страницы клиента и разработчика
    @IBAction func clickButton(_ sender: Any) {
        
        if flag == true {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc : DeveloperViewController = mainStoryboard.instantiateViewController(withIdentifier: "goDeveloper") as! DeveloperViewController
            self.present(vc, animated: false, completion: nil)
        } else {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc : ClientViewController = mainStoryboard.instantiateViewController(withIdentifier: "goClient") as! ClientViewController
            self.present(vc, animated: false, completion: nil)
        }
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(array[row])
        if row == 1 {
            self.flag = true
            self.label.text = "as developer"
        } else {
            self.flag = false
            self.label.text = "as client"
        }
    }
}
