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

class ViewController: UIViewController,ImagePickerControllerDelegate {
    
    
    
    var picker = ImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var parameters = Pickle.Parameters()
        parameters.allowedSelections = .limit(to: 1)

        picker = ImagePickerController(
            selectedAssets: [],
            configuration: parameters,
            cameraType: UIImagePickerController.self
        )
        picker.delegate = self as? ImagePickerControllerDelegate
        //present(picker, animated: true,completion: nil)
        
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: ImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: ImagePickerController, didFinishPickingImageAssets assets: [PHAsset]) {
        
    }
    func imagePickerController(_ picker: ImagePickerController, shouldLaunchCameraWithAuthorization status: AVAuthorizationStatus) -> Bool {
        return true
    }
    
}

