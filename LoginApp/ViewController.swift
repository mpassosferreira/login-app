//
//  ViewController.swift
//  LoginApp
//
//  Created by Marcio P Ferreira on 14/09/20.
//  Copyright © 2020 Passos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var buttonSave: UIButton!
    
    @IBOutlet var uiView: UIView!
    
    var userControl = UserControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
    }

    @IBAction func saveUser(_ sender: UIButton) {
        
        let fieldsValidated = userControl.validateFields(textFieldEmail: textFieldEmail, textFieldPassword: textFieldPassword)
        
        if fieldsValidated {
            
            let user = User(email: textFieldEmail.text!, password: textFieldPassword.text!)
            
            let userNotExist = userControl.validateUserNotExist(user: user)
             
             if userNotExist {
                 userControl.addUser(user: user)
                 for item in userControl.arrayUsers{
                     print(item.email)
                     print(item.password)
                 }
                uiView.backgroundColor = UIColor.green
             } else {
                 uiView.backgroundColor = UIColor.red
             }
            
             textFieldEmail.text = ""
             textFieldPassword.text = ""
        } else {
            showMessage()
        }
    }
    
    func showMessage() {
        //alert entra aqui
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldEmail.resignFirstResponder()
        return true
    }
}

class User {
    
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

class UserControl {
        
    var arrayUsers = [User]()
    
    func addUser(user: User) {
        arrayUsers.append(user)
    }
    
    func validateFields(textFieldEmail: UITextField, textFieldPassword: UITextField) -> Bool {
        if textFieldEmail.text != nil  && !textFieldEmail.text!.isEmpty && textFieldPassword.text != nil  && !textFieldPassword.text!.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func validateUserNotExist(user: User) -> Bool {
        for item in arrayUsers {
            if item.email == user.email {
                return false
            }
        }
        return true
    }
}
