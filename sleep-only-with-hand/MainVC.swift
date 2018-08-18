//
//  MainVC.swift
//  sleep-only-with-hand
//
//  Created by 이창현 on 2018. 8. 18..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var mainView1: UIView!
    
    @IBOutlet weak var mainView2: UIView!
    
    @IBOutlet weak var playerImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        var gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.colors = [
            UIColor.black.cgColor, // Top
            //UIColor(red:0, green:1, blue:0, alpha:1).cgColor, // Middle
            UIColor.clear.cgColor // Bottom
        ]
        imageView.layer.addSublayer(gradient)
        // Do any additional setup after loading the view.
        
        imageView.blurView.setup(style: UIBlurEffectStyle.dark , alpha: 0.9).enable()
        mainView1.blurView.setup(style: UIBlurEffectStyle.extraLight , alpha: 0.9).enable()
        mainView2.blurView.setup(style: UIBlurEffectStyle.extraLight, alpha: 0.9).enable()
        
        playerImageView.sd_setImage(with: URL(string:"https://t1.daumcdn.net/cfile/tistory/99CF8C505B47FD5733"), completed: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        API.partnerAPI.check { (str) in
            
            let alert = UIAlertController(title: "알림", message: "\(str) 님의 요청이 들어왔습니다. 수락하시겠습니까?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: { (action) in
                self.accept(boolean: true)
                
            }))
            alert.addAction(UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: { (action) in
                self.accept(boolean: false)
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func accept(boolean:Bool) {
        API.partnerAPI.accept(with: boolean, completion: { (response) in
            if response["status"].intValue == 200 {
                self.show_alert(with: response["message"].stringValue)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func playButton(_ sender: Any) {
        
    }
    
}
