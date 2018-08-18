//
//  LoveVC.swift
//  sleep-only-with-hand
//
//  Created by 이창현 on 2018. 8. 18..
//  Copyright © 2018년 이창현. All rights reserved.
//

import UIKit
import SDWebImage

class LoveVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(LoveVC.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.gray
        
        return refreshControl
    }()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchField: UITextField!
    
    var items:[String] = ["검색 결과 없음"]
    var items_image:[String] = []
    var items_token:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.addSubview(refreshControl)

        // Do any additional setup after loading the view.
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        API.loveAPI.find_user(with: "http://aws.soylatte.kr:3000/data/user", name: searchField.text ?? "") { (response) in
            if response.count == 0 {
                self.items = ["검색 결과 없음"]
                self.view.endEditing(true)
                return
            }
            
            self.items = []
            self.items_image = []
            self.items_token = []
            
            let name_list = response.map{ $0["user_data"]["name"].stringValue}
            
            let image_list = response.map{ $0["user_data"]["profile_img_url"].stringValue}
            let token_list = response.map{ $0["token"].stringValue}
            
            
            for i in name_list {
                self.items.append(i)
            }
            for i in image_list {
                self.items_image.append(baseURL+i)
            }
            for i in token_list {
                self.items_token.append(i)
            }
            
            self.tableView.reloadData()
        }
        self.view.endEditing(true)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        cell.textLabel?.text = items[indexPath.row]
        if items_image.count > 0 {
            
            let t = items_image[indexPath.row].replacingOccurrences(of: "undefined", with: "")
            print(t)
            
            cell.imageView?.sd_setImage(with: URL(string:t)!, completed: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        API.partnerAPI.make(partner_token: items_token[indexPath.row]) { (response) in
            let alert = UIAlertController(title: "알림", message: response["message"].stringValue, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: { (action) in
                if response["status"].intValue == 200 {
                    self.performSegue(withIdentifier: "register_complete", sender: self)
                }
            }))
            
            self.present(alert, animated: true, completion: nil)
            
            
        }
        //self.performSegue(withIdentifier: "login", sender: self)
    }
    
    func move() {
        print("login")
    }
    
    
}
