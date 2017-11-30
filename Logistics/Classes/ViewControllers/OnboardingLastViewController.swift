//
//  OnboardingLastViewController.swift
//  Logistics
//
//  Created by Daniyal Ansari on 11/21/17.
//  Copyright © 2017 com.tnb. All rights reserved.
//

import UIKit

class OnboardingLastViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dismissOnboardingFlow() {
        //PersistanceHelper.setOnboardingShown()
        self.dismiss(animated: true, completion: nil)
    }
    
}
