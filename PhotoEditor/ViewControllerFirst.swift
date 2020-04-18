//
//  ViewControllerFirst.swift
//  
//
//  Created by Дарья Косякова on 2/21/20.
//


import UIKit
import Foundation

class ViewControllerFirst: UIViewController {
  
    var flag = false
    var myUser = User()
    var developerAcc = DeveloperAccount()
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var label: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
    }

    @available(iOS 13.0, *)
    @IBAction func clickButton(_ sender: Any) {
        if flag == true {

            alertPassword()
            }
        else {
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc : ClientViewController = mainStoryboard.instantiateViewController(withIdentifier: "goClient") as! ClientViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        }
    
    func printAlert(title: String, message: String, style: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let actions = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        alert.addAction(actions)
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertPassword() {
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Enter", message: "Input your data", preferredStyle: .alert)


        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "User"
        }

        alert.addTextField { (textFieldPass) in
            textFieldPass.placeholder = "Password"
            textFieldPass.isSecureTextEntry = true
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { [alert] (_) in
            print("cerrar")
        }))

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            let textFieldPass = alert?.textFields![1]
            
            
            if textField!.text!.count > 20 {
                           self.printAlert(title: "Error", message: "The field name should constist only < 20 symbols", style: .alert)
                       }
            
            for developer in self.developerAcc.developerAccounts {
                if developer.login == textField?.text {
                    if developer.pass == textFieldPass?.text {
                        //go to main
                        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc : ViewController22 = mainStoryboard.instantiateViewController(withIdentifier: "goDev") as! ViewController22
                        self.present(vc, animated: false, completion: nil)
                    } else {
                        self.printAlert(title: "Error", message: "The pass isn't correct", style: .alert)
                    }
                    
                }
            }
        }))
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    func filterContent(searchText: String, strToFiltr: String) -> String {
        var text = strToFiltr
        text = strToFiltr.filter { searchText.contains($0) }
        return text
    }


}
extension ViewControllerFirst: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
}

extension ViewControllerFirst: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myUser.array[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(myUser.array[row])
        if row == 1 {
            self.flag = true
            self.label.text = "as developer"
            alertPassword()
        } else {
            self.flag = false
            self.label.text = "as client"
        }
    }
}


