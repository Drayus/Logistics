//
//  BaseViewController.swift
//  Logistics
//
//  Created by Daniyal Ansari on 11/15/17.
//  Copyright © 2017 com.tnb. All rights reserved.
//


import UIKit
import Moya
import Result
import MBProgressHUD


class BaseViewController: UIViewController {
    
    var hud:MBProgressHUD?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    // MARK: Class Methods
    
    func setupRightMenuIcon() {
        self.addRightBarButtonWithImage(UIImage(named: "Menu_Icon")!)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
    }
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("GENERAL_TEXT_OK", comment: "OK"), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: MBProgressHUD
    
    func showDialog() {
        dismissHud()
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func showDialog(message:String) {
        dismissHud()
        
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud!.mode = .indeterminate
        hud!.label.text = message;
    }
    
    func showToast(message:String) {
        dismissHud()
        
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud!.mode = .text
        hud!.label.text = message;
        hud!.label.font = UIFont.systemFont(ofSize: 10.0)
        hud?.hide(animated: true, afterDelay: 3.0)
    }
    
    func dismissHud() {
        MBProgressHUD.hide(for: self.view, animated: false)
    }
}
