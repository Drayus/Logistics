//
//  HomeViewController.swift
//  Logistics
//
//  Created by macbook on 11/20/17.
//  Copyright © 2017 com.tnb. All rights reserved.
//

import UIKit
import Moya

class HomeViewController: BaseViewController {
    
    static let sharedInstance: HomeViewController = HomeViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.performAdditionalUICustomization()
        self.checkVersion()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func performAdditionalUICustomization() {
        
    }
    
    
    func checkVersion() {
        
        showDialog(message: "CHECKING_VERSION")
        
        let endpointClosure = { (target: NetworkHelper) -> Endpoint<NetworkHelper> in
            let closureEndpoint = Endpoint<NetworkHelper>(
                url: target.baseURL.appendingPathComponent(target.path).absoluteString,
                sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
            NetworkRequestManager.sharedInstance.currentEndpoint = closureEndpoint.adding(newHTTPHeaderFields: ["Authorization": "Bearer \(AuthenticationResponseManager.sharedInstance.fetchAccessToken()!)"])
            return NetworkRequestManager.sharedInstance.currentEndpoint!
        }
        NetworkRequestManager.sharedInstance.execute(request: NetworkHelper.GetLatestVersion, withEndpointClosure: endpointClosure) { result in
            
            switch result {
            case let .success(response):
                self.dismissHud()
                let infoDictionary = GetVersionResponseManager.sharedInstance.processGetVersionResponse(response: response)
                if (infoDictionary["HAS_ERROR"] as? Bool == true) {
                    self.showAlert(title: "ERROR_TITLE_ERROR", message: infoDictionary["ERROR_MESSAGE"] as! String)
                } else {
                    //TODO: Fix Error, Wrong Response Check
                    if(GetVersionResponseManager.sharedInstance.AppVersion?.LatestVersion == "1.0") {
                        self.showAlert(title: "VERSION_OUT_OF_DATE", message: "The current version is out of date, please download the latest version.")
                        //TODO: Redirect to URL Link
                    }
                    
                    else {
                        var newController: UIViewController?
                        let storyboard = UIStoryboard(name:"AppMain", bundle: nil)
                        
                        newController = storyboard.instantiateViewController(withIdentifier: "AppMainNavigationController") as! UINavigationController
                        
                        AppDelegate.sharedApplication().changeCurrentControllerWith(newController: newController!)
                    }
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
}
