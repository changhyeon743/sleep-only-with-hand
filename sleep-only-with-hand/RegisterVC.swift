//
//  ViewController.swift
//  sleep-only-with-hand
//
//  Created by 이창현 on 2018. 8. 18..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit
import Pickle
import Photos

var token:String = ""

class RegisterVC: UIViewController,ImagePickerControllerDelegate {
    
    var images:[PHAsset] = []
    
    var picker = ImagePickerController()
    
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var genderField: UITextField!
    
    @IBOutlet weak var phoneField: UITextField!
    
    @IBOutlet weak var profileView: UIImageView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        var parameters = Pickle.Parameters()
        parameters.allowedSelections = .limit(to: 1)

        picker = ImagePickerController(
            selectedAssets: [],
            configuration: parameters,
            cameraType: UIImagePickerController.self
        )
        picker.delegate = self
        //present(picker, animated: true,completion: nil)
        setToolBar()
    }
    
    func setToolBar() {
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.tabBarDonePressed))
        
        toolbar.setItems([flexibleSpace,doneBtn], animated: false)
        
        
        nameField.inputAccessoryView = toolbar
        passwordField.inputAccessoryView = toolbar
        idField.inputAccessoryView = toolbar
        genderField.inputAccessoryView = toolbar
        phoneField.inputAccessoryView = toolbar
    }
    
    @objc func tabBarDonePressed() {
        self.view.endEditing(true)
    }

    @IBAction func imgButtonPressed(_ sender: UIButton) {
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func action_event(_ sender: UIButton) {
        guard let id = idField.text,!id.isEmpty else {
            return
        }
        guard let password = passwordField.text,!password.isEmpty else {
            return
        }
        guard let name = nameField.text,!name.isEmpty else {
            return
        }
        guard let gender = genderField.text,!gender.isEmpty else {
            return
        }
        guard let phone = phoneField.text,!phone.isEmpty else {
            return
        }
        if let image = profileView.image {
            API.userAPI.register(name: name, id: id, password: password, gender: gender, phone: phone, profile: image) { (response) in
                if response["status"] == 200 {
                    self.setToken(with: response["data"].stringValue)
                } else {
                    self.show_alert(with: response.description)
                }
            }
        }
        
        
    }
    
    func setToken(with:String) {
        token = with
        print("register with: \(token)")
        self.performSegue(withIdentifier: "findlove", sender: self) //(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: ImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: ImagePickerController, didFinishPickingImageAssets assets: [PHAsset]) {
        images = assets
        picker.dismiss(animated: true) {
            if self.images.count > 0 {
                self.profileView.image = image.getAssetThumbnail(asset: self.images[0])
            }
        }
    }
    
    func imagePickerController(_ picker: ImagePickerController, shouldLaunchCameraWithAuthorization status: AVAuthorizationStatus) -> Bool {
        return true
    }
    
}

