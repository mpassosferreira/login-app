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
        buttonSave.layer.cornerRadius = 5
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
        cleanForm()
    }

    @IBAction func saveUser(_ sender: UIButton) {
                               
         let user = User(email: textFieldEmail.text!, password: textFieldPassword.text!)
                     
         if userControl.validateUserNotExist(user: user) {
             userControl.addUser(user: user)
             showLoggedUsers(uiView: uiView)
             uiView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
             showMessage(title: "Welcome!", message: "We have a special offer to you. 💲💲💲")
         } else {
             uiView.backgroundColor = #colorLiteral(red: 1, green: 0.6471286626, blue: 0.6249221453, alpha: 1)
             showMessage(title: "⛔️", message: "You did it already.")
         }
         cleanForm()
    }
    
    func showLoggedUsers(uiView: UIView) {
        if userControl.arrayUsers.count > 0 {
            var yPos = 380
            let buttonTitle = UIButton()
            buttonTitle.tag = 999
            buttonTitle.setTitle("Logged users", for: .normal)
            buttonTitle.backgroundColor = UIColor.systemGray
            buttonTitle.layer.cornerRadius = 5
            buttonTitle.contentHorizontalAlignment = .center
            buttonTitle.frame = CGRect( x:25, y:yPos, width:370, height: 40)
            uiView.addSubview(buttonTitle)
            
            yPos += 43
            var i = 1000
            for user in userControl.arrayUsers {
                let buttonSingOut = UIButton()
                buttonSingOut.addTarget(self, action: #selector(signOut), for: .touchUpInside)
                buttonSingOut.tag = i
                buttonSingOut.setTitle(" ❌  " + user.email, for: .normal)
                buttonSingOut.backgroundColor = UIColor.systemGray3
                buttonSingOut.layer.cornerRadius = 5
                buttonSingOut.contentHorizontalAlignment = .left
                buttonSingOut.frame = CGRect( x:25, y:yPos, width:370, height: 40)
                uiView.addSubview(buttonSingOut)
                yPos += 43
                i = i + 1
            }
        }
    }
    
     @objc func signOut(_ sender: UIButton) {
        for subview in uiView.subviews {
            if subview.tag >= 999 {
                subview.removeFromSuperview()
            }
        }
        userControl.arrayUsers.remove(at: sender.tag - 1000)
        showLoggedUsers(uiView: uiView)
        uiView.setNeedsDisplay()
     }
    
    func showMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .cancel) { (UIAlertAction) in
            self.uiView.backgroundColor = UIColor.white
        }
        alert.addAction(okAction)
        self.present(alert, animated: true) {
        }
    }
    
    func cleanForm() {
        buttonSave.isEnabled = false
        buttonSave.backgroundColor = UIColor.systemGray4
        textFieldEmail.text = ""
        textFieldPassword.text = ""
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldEmail {
            textFieldPassword.becomeFirstResponder()
        } else {
            textFieldPassword.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString: String) -> Bool {
        
        let email = textFieldEmail.text!
        let password = textFieldPassword.text!
        buttonSave.isEnabled = userControl.validateFields(email: email, password: password)
        if buttonSave.isEnabled {
            buttonSave.backgroundColor = UIColor.systemBlue
        } else {
            buttonSave.backgroundColor = UIColor.systemGray4
        }
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
    
    func validateFields(email: String, password: String) -> Bool {
        if !email.isEmpty && !password.isEmpty {
            return true
        }
        return false
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
