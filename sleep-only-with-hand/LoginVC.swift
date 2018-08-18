//
//  LoginVC.swift
//  sleep-only-with-hand
//
//  Created by 이창현 on 2018. 8. 18..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var idField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.backgroundColor = UIColor.mainColor
        loginButton.layer.cornerRadius = 6
        loginButton.clipsToBounds = true
        
        
        registerButton.backgroundColor = UIColor.white
        registerButton.layer.borderColor = UIColor.mainColor.cgColor
        registerButton.layer.borderWidth = 1
        registerButton.layer.cornerRadius = 6
        registerButton.clipsToBounds = true
        
        idField.layer.borderWidth = 1
        idField.layer.borderColor = UIColor.mainColor.cgColor
        idField.layer.cornerRadius = 6
        idField.clipsToBounds = true
        
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = UIColor.mainColor.cgColor
        passwordField.layer.cornerRadius = 6
        passwordField.clipsToBounds = true
        
        // Do any additional setup after loading the view.
        setToolBar()
    }
    
    func setToolBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.tabBarDonePressed))
        
        toolbar.setItems([flexibleSpace,doneBtn], animated: false)
        
        
        passwordField.inputAccessoryView = toolbar
        idField.inputAccessoryView = toolbar
    }
    
    @objc func tabBarDonePressed() {
        self.view.endEditing(true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        
        guard let id = idField.text,!id.isEmpty else {
            return
        }
        guard let password = passwordField.text,!password.isEmpty else {
            return
        }
        API.userAPI.login(id: id, password: password) { (response) in
            if (response["status"] == 200) {
                self.setToken(with: response["data"].stringValue)
            } else {
                self.show_alert(with: response["message"].stringValue)
            }

        }
    }
    
    func setToken(with:String) {
        token = with
        print("login with: \(token)")
        self.performSegue(withIdentifier: "login", sender: self)
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "register", sender: self)
    }
    
    
}
