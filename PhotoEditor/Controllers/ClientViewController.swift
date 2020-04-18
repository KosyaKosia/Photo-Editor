//
//  ClientViewController.swift
//  PhotoEditor
//
//  Created by Дарья Косякова on 2/21/20.
//  Copyright © 2020 Дарья Косякова. All rights reserved.
//

import UIKit

class ClientViewController: UIViewController {

    @IBOutlet weak var email: UITextField!

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var gmailLabel: UILabel!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var returnPassword: UITextField!
    
    var pass = ""
    var user = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.endEditing(true)
        // Do any additional setup after loading the view.
        
        email.delegate = self
        name.delegate = self
        surname.delegate = self
        password.delegate = self
        returnPassword.delegate = self
        
        showOrHide()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as? UITouch {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    
  
    @IBAction func returnButton(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc : ViewControllerFirst = mainStoryboard.instantiateViewController(withIdentifier: "main") as! ViewControllerFirst
               self.present(vc, animated: true, completion: nil)
    }
    
    
 
    
    func printAlert(title: String, message: String, style: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let actions = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        alert.addAction(actions)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func nameFieldAction(_ sender: UITextField) {
        let сharacters = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNMабвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ "
        guard let text = sender.text else { return }
        sender.text = filterContent(searchText: сharacters, strToFiltr: text)
        
        if sender.text!.count > 20 {
            printAlert(title: "Error", message: "The field name should consist 3..20 symbols", style: .alert)
            sender.text?.removeLast()
        }
        
        
        if text != sender.text {
            printAlert(title: "Error", message: "Error symbol", style: .alert)
        }
        
        self.user = sender.text!
        
    }
    
    @IBAction func SurnameFieldAction(_ sender: UITextField) {
        
        let сharacters = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNMабвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ "
        guard let text = sender.text else { return }
        sender.text = filterContent(searchText: сharacters, strToFiltr: text)
        
        if sender.text!.count > 20 {
                   printAlert(title: "Error", message: "The field name should consist < 20 symbols", style: .alert)
            sender.text?.removeLast()
               }
        
        if text != sender.text {
            printAlert(title: "Error", message: "Error symbol", style: .alert)
        }
        
    }
    @IBAction func passwordFiledAction(_ sender: UITextField) {
        
        let сharacters = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNMабвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ 1234567890"
        guard let text = sender.text else { return }
        sender.text = filterContent(searchText: сharacters, strToFiltr: text)
        
        if sender.text!.count > 20 {
               printAlert(title: "Error", message: "The field password should consist <20 symbols", style: .alert)
        sender.text?.removeLast()
           }
        
        if text != sender.text {
            printAlert(title: "Error", message: "Error symbol", style: .alert)
        }
        
        
        self.pass = sender.text!
    }
    
    @IBAction func returnPasswordAction(_ sender: UITextField) {

        
        if sender.text != password.text! {
            printAlert(title: "Error", message: "The password doesn't confirm", style: .alert)
            sender.text?.removeAll()
        }

    }
    
    @IBAction func emailAction(_ sender: UITextField) {
        
        let сharacters = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM @."
        guard let text = sender.text else { return }
        sender.text = filterContent(searchText: сharacters, strToFiltr: text)
        
       if sender.text!.count > 20 {
               printAlert(title: "Error", message: "The field name should consist < 20 symbols", style: .alert)
        sender.text?.removeLast()
           }
        
        if text != sender.text {
            printAlert(title: "Error", message: "Error symbol", style: .alert)
        }
        
        print(sender.text! + "" + gmailLabel.text!)
    }
    
    
    func filterContent(searchText: String, strToFiltr: String) -> String {
        var text = strToFiltr
        text = strToFiltr.filter { searchText.contains($0) }
        return text
    }
    
    func showOrHide() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    
    func alertPassword() {
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Enter your dats", message: "Enter to log in", preferredStyle: .alert)


        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "User"
        }

        alert.addTextField { (textFieldPass) in
            textFieldPass.placeholder = "Password"
            textFieldPass.isSecureTextEntry = true
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: { [weak alert] (_) in
            print("cerrar")
        }))

        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            let textFieldPass = alert?.textFields![1]
            
            if textField?.text != self.user {
                self.printAlert(title: "Error", message: "The user is out", style: .alert)
            }
            if textFieldPass?.text != self.pass {
                self.printAlert(title: "Error", message: "The pass isn't correct", style: .alert)
            }
            print("Text field: \(String(describing: textField!.text))")
            print("Text field: \(textFieldPass!.text)")
            
            
            //go to main
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc : ViewController2 = mainStoryboard.instantiateViewController(withIdentifier: "goPhoto") as! ViewController2
            self.present(vc, animated: false, completion: nil)
            
        
        }))
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func saveButtonClicl(_ sender: Any) {
       
        let arrayOfFields = [name, surname, password, returnPassword, email]
                
                for (index, value) in arrayOfFields.enumerated() {
                    if value?.text == "" {
                        printAlert(title: "ERROR", message: "TextField \(index + 1) is empty!!!", style: .alert)
                    }
                }

        alertPassword()
    }
    
}

extension ClientViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y += (keyboardSize.height - keyboardSize.height * 1.1)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
