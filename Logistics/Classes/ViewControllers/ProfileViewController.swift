//
//  ProfileViewController.swift
//  Logistics
//
//  Created by Daniyal Ansari on 11/15/17.
//  Copyright © 2017 com.tnb. All rights reserved.
//

import UIKit
import Moya

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var UsernameLabel: UILabel?
    @IBOutlet weak var FullnameLabel: UILabel?
    @IBOutlet weak var WorkAddressLabel: UILabel?
    @IBOutlet weak var OfficeNumberCityCodeLabel: UILabel?
    @IBOutlet weak var OfficeNumberLabel: UILabel?
    @IBOutlet weak var HandPhoneNumberCityCodeLabel: UILabel?
    @IBOutlet weak var HandPhoneNumberLabel: UILabel?
    @IBOutlet weak var FaxNumberCityCodeLabel: UILabel?
    @IBOutlet weak var FaxNumberLabel: UILabel?
    @IBOutlet weak var CostCenterLabel: UILabel?
    @IBOutlet weak var BusinessAreaLabel: UILabel?
    @IBOutlet weak var CompanyCodeLabel: UILabel?
    @IBOutlet weak var ElementCostLabel: UILabel?
    @IBOutlet weak var ChargingCodeLabel: UILabel?
    
    @IBOutlet var EditButton: UIButton?
    
    
    static let sharedInstance: ProfileViewController = ProfileViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //self.setupRightMenuIcon()
        self.performAdditionalUICustomization()
        
        self.fetchUserProfile()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func performAdditionalUICustomization() {
    
    }
    
    
    func updateUserProfile() {
        
        if UserProfileResponseManager.sharedInstance.userProfile?.Fullname != nil {
            self.FullnameLabel?.text = UserProfileResponseManager.sharedInstance.userProfile?.Fullname
        } else {
            self.FullnameLabel?.text = "--"
        }
        
        
        if UserProfileResponseManager.sharedInstance.userProfile?.Username != nil {
            self.UsernameLabel?.text = UserProfileResponseManager.sharedInstance.userProfile?.Username
        } else {
            self.UsernameLabel?.text = "--"
        }
        
        if UserProfileResponseManager.sharedInstance.userProfile?.WorkAddress != nil {
            self.WorkAddressLabel?.text = UserProfileResponseManager.sharedInstance.userProfile?.WorkAddress
        } else {
            self.WorkAddressLabel?.text = "--"
        }
        
        if UserProfileResponseManager.sharedInstance.userProfile?.OfficeNumberCityCode != nil {
            self.OfficeNumberCityCodeLabel?.text = UserProfileResponseManager.sharedInstance.userProfile?.OfficeNumberCityCode
        } else {
            self.OfficeNumberCityCodeLabel?.text = "--"
        }
        
        if UserProfileResponseManager.sharedInstance.userProfile?.OfficeNumber != nil {
            self.OfficeNumberLabel?.text = UserProfileResponseManager.sharedInstance.userProfile?.OfficeNumber
        } else {
            self.OfficeNumberLabel?.text = "--"
        }
        
        if UserProfileResponseManager.sharedInstance.userProfile?.HandPhoneNumberCityCode
            != nil {
            self.HandPhoneNumberCityCodeLabel?.text = UserProfileResponseManager.sharedInstance.userProfile?.HandPhoneNumberCityCode
        } else {
            self.HandPhoneNumberCityCodeLabel?.text = "--"
        }
        
        if UserProfileResponseManager.sharedInstance.userProfile?.HandPhoneNumber
            != nil {
            self.HandPhoneNumberLabel?.text = UserProfileResponseManager.sharedInstance.userProfile?.HandPhoneNumber
        } else {
            self.HandPhoneNumberLabel?.text = "--"
        }
        
        if UserProfileResponseManager.sharedInstance.userProfile?.FaxNumberCityCode
            != nil {
            self.FaxNumberCityCodeLabel?.text = UserProfileResponseManager.sharedInstance.userProfile?.FaxNumberCityCode
        } else {
            self.FaxNumberCityCodeLabel?.text = "--"
        }
        
        
        if UserProfileResponseManager.sharedInstance.userProfile?.FaxNumber != nil {
            self.FaxNumberLabel?.text = UserProfileResponseManager.sharedInstance.userProfile?.FaxNumber
        } else {
            self.FaxNumberLabel?.text = "--"
        }
        
        
        if UserProfileResponseManager.sharedInstance.userProfile?.CostCenter != nil {
            self.CostCenterLabel?.text = UserProfileResponseManager.sharedInstance.userProfile?.CostCenter
        } else {
            self.CostCenterLabel?.text = "--"
        }
        
        
        if UserProfileResponseManager.sharedInstance.userProfile?.BusinessArea != nil {
            self.BusinessAreaLabel?.text = UserProfileResponseManager.sharedInstance.userProfile?.BusinessArea
        } else {
            self.BusinessAreaLabel?.text = "--"
        }
        
        
        if UserProfileResponseManager.sharedInstance.userProfile?.CompanyCode != nil {
            self.CompanyCodeLabel?.text = UserProfileResponseManager.sharedInstance.userProfile?.CompanyCode
        } else {
            self.CompanyCodeLabel?.text = "--"
        }
        
        
        if UserProfileResponseManager.sharedInstance.userProfile?.ElementCost != nil {
            self.ElementCostLabel?.text = UserProfileResponseManager.sharedInstance.userProfile?.ElementCost
        } else {
            self.ElementCostLabel?.text = "--"
        }
        
        
        if UserProfileResponseManager.sharedInstance.userProfile?.ChargingCode != nil {
            self.ChargingCodeLabel?.text = UserProfileResponseManager.sharedInstance.userProfile?.ChargingCode
        } else {
            self.ChargingCodeLabel?.text = "--"
        }
        
    }
    
    
    func fetchUserProfile() {
        
        // Get User Profile
        showDialog(message: "NETWORK_ACTIVITY_LOADING")
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
        NetworkRequestManager.sharedInstance.execute(request: NetworkHelper.GetProfile, withEndpointClosure: endpointClosure) { result in
            
            switch result {
            case let .success(response):
                self.dismissHud()
                let infoDictionary = UserProfileResponseManager.sharedInstance.processUserProfileResponse(response: response)
                if (infoDictionary["HAS_ERROR"] as? Bool == true) {
                    self.showAlert(title: "ERROR_TITLE_ERROR", message: infoDictionary["ERROR_MESSAGE"] as! String)
                } else {
                    self.updateUserProfile()
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
