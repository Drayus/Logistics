//
//  AppMainViewController.swift
//  Logistics
//
//  Created by Daniyal Ansari on 11/13/17.
//  Copyright © 2017 com.tnb. All rights reserved.
//

import UIKit
import Moya

class AppMainViewController:UIViewController {
    
    @IBOutlet var ProfileButton: UIButton?
    @IBOutlet var SettingButton: UIButton?
    @IBOutlet var LogOutButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Specify the allowed content types of your application via the Info.plist.
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToProfileView() {
        var newController: UIViewController?
        let storyboard = UIStoryboard(name:"AppMain", bundle: nil)
        
        newController = storyboard.instantiateViewController(withIdentifier: "ProfileNavigationController") as! UINavigationController
        
        AppDelegate.sharedApplication().changeCurrentControllerWith(newController: newController!)
    }
    
}
