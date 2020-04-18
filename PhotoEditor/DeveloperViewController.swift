//
//  DeveloperViewController.swift
//  
//
//  Created by Дарья Косякова on 2/21/20.
//

import UIKit

class DeveloperViewController: UIViewController {

    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var surname: UITextField!
    
    @IBOutlet weak var email: UITextField!
    

    @IBOutlet weak var password: UITextField!
    
    
    @IBOutlet weak var returnPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.delegate = self
        surname.delegate = self
        email.delegate = self
        password.delegate = self
        returnPassword.delegate = self
        
        showOrHide()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    @IBAction func nameEntry(_ sender: Any) {
//        let сharacters = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM"
//        guard let text = sender.text else { return }
//        sender.text = filterContent(searchText: сharacters, strToFiltr: text)
        
    }
    
    @IBAction func surnameEntry(_ sender: Any) {
    }
    @IBAction func emailEntry(_ sender: Any) {
    }
    @IBAction func returnPasswordEntry(_ sender: Any) {
    }
    @IBAction func passwordEntry(_ sender: Any) {
    }
    @IBAction func returnButton(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc : ViewControllerFirst = mainStoryboard.instantiateViewController(withIdentifier: "main") as! ViewControllerFirst
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let arrayOfFields = [name, surname, email, password, returnPassword]
        
        for (index, value) in arrayOfFields.enumerated() {
            if value?.text == "" {
                printAlert(title: "ERROR", message: "TextField \(index + 1) is empty!!!", style: .alert)
            }
        }
        
        if (self.password.text?.count)! > 4 {
            printAlert(title: "ERROR", message: "Num of card must have 1 to 4 symbols", style: .alert)
        }
        
        printAlert(title: "WELCOME", message: "Hello, Dear \(self.name.text!) \(self.surname.text!)! ", style: .alert)
    }
    
    func printAlert(title: String, message: String, style: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let actions = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        alert.addAction(actions)
        self.present(alert, animated: true, completion: nil)
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
}

extension DeveloperViewController: UITextFieldDelegate {
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
