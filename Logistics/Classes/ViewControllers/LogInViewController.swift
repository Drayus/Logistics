//
//  LogInViewController.swift
//  Logistics
//
//  Created by Daniyal Ansari on 11/8/17.
//  Copyright © 2017 com.tnb. All rights reserved.
//

import UIKit
import Moya
import Result


class LogInViewController:BaseViewController {
    
    @IBOutlet var loginUsername:UITextField?
    @IBOutlet var loginPassword:UITextField?
    @IBOutlet var loginButton:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Specify the allowed content types of your application via the Info.plist.
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //custom UI modifications after launch
        self.performAdditionalUICustomization()
        
        if (AuthenticationResponseManager.sharedInstance.fetchAccessToken() != nil) {
            AppDelegate.sharedApplication().setupDashboardWithSlideMenu()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //custom UI modifications after launch
    func performAdditionalUICustomization() {
    
    }
    
    
    func signInUserWithLoadingMessage( loadingText: String ) {
        
        showDialog(message: loadingText)
        
        let endpointClosure = { (target: NetworkHelper) -> Endpoint<NetworkHelper> in
            let endpoint = Endpoint<NetworkHelper>(
                url: target.baseURL.appendingPathComponent(target.path).absoluteString,
                sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
            return endpoint.adding(newHTTPHeaderFields: ["Authorization": NetworkHelper.authorizationBasicValue, "Content-Type": "application/json"])
        }
        
        NetworkRequestManager.sharedInstance.execute(request: NetworkHelper.Authentication(Username: (self.loginUsername?.text)!, Password: (self.loginPassword?.text)!), withEndpointClosure: endpointClosure) { result in
            
            switch result {
            case let .success(response):
                self.dismissHud()
                let infoDictionary = AuthenticationResponseManager.sharedInstance.processAuthenticationResponse(response: response)
                if (infoDictionary["HAS_ERROR"] as? Bool == true) {
                    self.showAlert(title: "ERROR_TITLE_ERROR", message: infoDictionary["ERROR_MESSAGE"] as! String)
                } else {
                    //AppDelegate.sharedApplication().setupDashboardWithSlideMenu()
                    AppDelegate.sharedApplication().setupOnboardingView()
                }
                break
                
            case let .failure(error):
                switch error {
                case .imageMapping(let response):
                    print(response)
                    break
                case .jsonMapping(let response):
                    print(response)
                    break
                case .statusCode(let response):
                    print(response)
                    break
                case .stringMapping(let response):
                    print(response)
                    break
                    
                default:
                    break
                }
                break
            }
        }
    }
    
    
    @IBAction func signInUser() {
        
        self.view.endEditing(true)
        var errorMsg:String = ""
        var isError = false
        
        if ((loginUsername?.text?.characters.count)! <= 0) {
            isError = true
            errorMsg = "ERROR_MESSAGE_ENTER_EMAIL"
        } else if ((loginPassword?.text?.characters.count)! <= 0) {
            isError = true
            errorMsg = "ERROR_MESSAGE_ENTER_PASSWORD"
        }
        
        //! TODO: Print Error Message on Wrong Username/Password use
        if (isError) {
            showAlert(title: "ERROR_MESSAGE_INCOMPLETE_INPUT", message: errorMsg)
        } else {
            self.signInUserWithLoadingMessage(loadingText: "NETWORK_ACTIVITY_SIGNING_IN")
        }
    }
}
