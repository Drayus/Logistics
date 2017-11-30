//
//  ProfileUpdateViewController.swift
//  Logistics
//
//  Created by Daniyal Ansari on 11/15/17.
//  Copyright © 2017 com.tnb. All rights reserved.
//

import UIKit
import Moya

class ProfileUpdateViewController: BaseViewController {
    
    @IBOutlet weak var UsernameTextField: UITextField?
    @IBOutlet weak var FullnameTextField: UITextField?
    @IBOutlet weak var WorkAddressTextField: UITextField?
    @IBOutlet weak var OfficeNumberCityCodeTextField: UITextField?
    @IBOutlet weak var OfficeNumberTextField: UITextField?
    @IBOutlet weak var HandPhoneNumberCityCodeTextField: UITextField?
    @IBOutlet weak var HandPhoneNumberTextField: UITextField?
    @IBOutlet weak var FaxNumberCityCodeTextField: UITextField?
    @IBOutlet weak var FaxNumberTextField: UITextField?
    @IBOutlet weak var CostCenterTextField: UITextField?
    @IBOutlet weak var BusinessAreaTextField: UITextField?
    @IBOutlet weak var CompanyCodeTextField: UITextField?
    @IBOutlet weak var ElementCostTextField: UITextField?
    @IBOutlet weak var ChargingCodeTextField: UITextField?
    
    @IBOutlet var SaveButton: UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.performAdditionalUICustomization()
        self.GetProfileTextFields()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func performAdditionalUICustomization() {
        
    }
    
    func GetProfileTextFields() {
        
        if UserProfileResponseManager.sharedInstance.userProfile?.Username != nil {
            self.UsernameTextField?.text = UserProfileResponseManager.sharedInstance.userProfile?.Username
        } else {
            self.UsernameTextField?.text = "--"
        }
        
        if UserProfileResponseManager.sharedInstance.userProfile?.Fullname != nil {
            self.FullnameTextField?.text = UserProfileResponseManager.sharedInstance.userProfile?.Fullname
        } else {
            self.FullnameTextField?.text = "--"
        }
        
        if UserProfileResponseManager.sharedInstance.userProfile?.WorkAddress != nil {
            self.WorkAddressTextField?.text = UserProfileResponseManager.sharedInstance.userProfile?.WorkAddress
        } else {
            self.WorkAddressTextField?.text = "--"
        }
        
        if UserProfileResponseManager.sharedInstance.userProfile?.OfficeNumberCityCode != nil {
            self.OfficeNumberCityCodeTextField?.text = UserProfileResponseManager.sharedInstance.userProfile?.OfficeNumberCityCode
        } else {
            self.OfficeNumberCityCodeTextField?.text = "--"
        }
        
        if UserProfileResponseManager.sharedInstance.userProfile?.OfficeNumber != nil {
            self.OfficeNumberTextField?.text = UserProfileResponseManager.sharedInstance.userProfile?.OfficeNumber
        } else {
            self.OfficeNumberTextField?.text = "--"
        }
        
        if UserProfileResponseManager.sharedInstance.userProfile?.HandPhoneNumberCityCode
            != nil {
            self.HandPhoneNumberCityCodeTextField?.text = UserProfileResponseManager.sharedInstance.userProfile?.HandPhoneNumberCityCode
        } else {
            self.HandPhoneNumberCityCodeTextField?.text = "--"
        }
        
        if UserProfileResponseManager.sharedInstance.userProfile?.HandPhoneNumber
            != nil {
            self.HandPhoneNumberTextField?.text = UserProfileResponseManager.sharedInstance.userProfile?.HandPhoneNumber
        } else {
            self.HandPhoneNumberTextField?.text = "--"
        }
        
        if UserProfileResponseManager.sharedInstance.userProfile?.FaxNumberCityCode
            != nil {
            self.FaxNumberCityCodeTextField?.text = UserProfileResponseManager.sharedInstance.userProfile?.FaxNumberCityCode
        } else {
            self.FaxNumberCityCodeTextField?.text = "--"
        }
        
        
        if UserProfileResponseManager.sharedInstance.userProfile?.FaxNumber != nil {
            self.FaxNumberTextField?.text = UserProfileResponseManager.sharedInstance.userProfile?.FaxNumber
        } else {
            self.FaxNumberTextField?.text = "--"
        }
        
        
        if UserProfileResponseManager.sharedInstance.userProfile?.CostCenter != nil {
            self.CostCenterTextField?.text = UserProfileResponseManager.sharedInstance.userProfile?.CostCenter
        } else {
            self.CostCenterTextField?.text = "--"
        }
        
        
        if UserProfileResponseManager.sharedInstance.userProfile?.BusinessArea != nil {
            self.BusinessAreaTextField?.text = UserProfileResponseManager.sharedInstance.userProfile?.BusinessArea
        } else {
            self.BusinessAreaTextField?.text = "--"
        }
        
        
        if UserProfileResponseManager.sharedInstance.userProfile?.CompanyCode != nil {
            self.CompanyCodeTextField?.text = UserProfileResponseManager.sharedInstance.userProfile?.CompanyCode
        } else {
            self.CompanyCodeTextField?.text = "--"
        }
        
        
        if UserProfileResponseManager.sharedInstance.userProfile?.ElementCost != nil {
            self.ElementCostTextField?.text = UserProfileResponseManager.sharedInstance.userProfile?.ElementCost
        } else {
            self.ElementCostTextField?.text = "--"
        }
        
        
        if UserProfileResponseManager.sharedInstance.userProfile?.ChargingCode != nil {
            self.ChargingCodeTextField?.text = UserProfileResponseManager.sharedInstance.userProfile?.ChargingCode
        } else {
            self.ChargingCodeTextField?.text = "--"
        }
        
    }
    
    
    
    @IBAction func UpdateProfileData() {

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
        
        
        NetworkRequestManager.sharedInstance.execute(request: NetworkHelper.UpdateProfile(
            Id: (UserProfileResponseManager.sharedInstance.userProfile?.Id)!,
            Username: (self.UsernameTextField?.text)!,
            Fullname: (self.FullnameTextField?.text)!,
            WorkAddress: (self.WorkAddressTextField?.text)!,
            OfficeNumberCityCode: (self.OfficeNumberCityCodeTextField?.text)!,
            OfficeNumber: (self.OfficeNumberTextField?.text)!,
            HandPhoneNumberCityCode: (self.HandPhoneNumberCityCodeTextField?.text)!,
            HandPhoneNumber: (self.HandPhoneNumberTextField?.text)!,
            FaxNumberCityCode: (self.FaxNumberCityCodeTextField?.text)!,
            FaxNumber: (self.FaxNumberTextField?.text)!,
            CostCenter: (self.CostCenterTextField?.text)!,
            BusinessArea: (self.BusinessAreaTextField?.text)!,
            CompanyCode: (self.CompanyCodeTextField?.text)!,
            ElementCost: (self.ElementCostTextField?.text)!,
            ChargingCode: (self.ChargingCodeTextField?.text)! ), withEndpointClosure: endpointClosure) { result in
            
            switch result {
            case let .success(response):
                self.dismissHud()
                let infoDictionary = UserProfileResponseManager.sharedInstance.processUserProfileResponse(response: response)
                if (infoDictionary["HAS_ERROR"] as? Bool == true) {
                    self.showAlert(title: "ERROR_TITLE_ERROR", message: infoDictionary["ERROR_MESSAGE"] as! String)
                } else {
                    
                    var newController: UIViewController?
                    let storyboard = UIStoryboard(name:"AppMain", bundle: nil)
                    
                    newController = storyboard.instantiateViewController(withIdentifier: "ProfileNavigationController") as! UINavigationController
                    
                    AppDelegate.sharedApplication().changeCurrentControllerWith(newController: newController!)
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
