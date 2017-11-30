//
//  APDraftViewController.swift
//  Logistics
//
//  Created by macbook on 11/22/17.
//  Copyright © 2017 com.tnb. All rights reserved.
//

import UIKit
import Moya

class APDraftViewController: BaseViewController {
    
    static let sharedInstance: APDraftViewController = APDraftViewController()
    
    //Profile Data
    @IBOutlet weak var IdTextField: UITextField?
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
    @IBOutlet weak var userIdTextField: UITextField?
    
    //Loading Data
    @IBOutlet weak var StartingLoadDateTextField: UITextField?
    @IBOutlet weak var EndingLoadDateTextField: UITextField?
    @IBOutlet weak var StartingLoadTimeTextField: UITextField?
    @IBOutlet weak var EndingLoadTimeTextField: UITextField?
    @IBOutlet weak var LPersonInChargeTextField: UITextField?
    @IBOutlet weak var LPICAreaCodePhoneNumberTextField: UITextField?
    @IBOutlet weak var LPICPhoneNumberTextField: UITextField?
    @IBOutlet weak var LLooadingLocationFromTextField: UITextField?
    @IBOutlet weak var LLoadingLocationToTextField: UITextField?
    @IBOutlet weak var LStateTextField: UITextField?
    @IBOutlet weak var LDistrictTextField: UITextField?
    @IBOutlet weak var LGPSLatTextField: UITextField?
    @IBOutlet weak var LGPSLongTextField: UITextField?
    @IBOutlet weak var DistanceInKMTextField: UITextField?
    
    //Unloading Data
    @IBOutlet weak var UnloadingDateTextField: UITextField?
    @IBOutlet weak var UnloadingStartTimeTextField: UITextField?
    @IBOutlet weak var UnloadingEndTimeTextField: UITextField?
    @IBOutlet weak var UPersonInChargeTextField: UITextField?
    @IBOutlet weak var UPICAreaCodePhoneNumberTextField: UITextField?
    @IBOutlet weak var UPICPhoneNumberTextField: UITextField?
    @IBOutlet weak var ULooadingLocationFromTextField: UITextField?
    @IBOutlet weak var ULoadingLocationToTextField: UITextField?
    @IBOutlet weak var UStateTextField: UITextField?
    @IBOutlet weak var UDistrictTextField: UITextField?
    @IBOutlet weak var UGPSLatTextField: UITextField?
    @IBOutlet weak var UGPSLongTextField: UITextField?
    
    //Task Data
    @IBOutlet weak var VendorAssignedDateTimeTextField: UITextField?
    @IBOutlet weak var StatusTextField: UITextField?
    @IBOutlet weak var CreatedDateTextField: UITextField?
    @IBOutlet weak var ModifiedDateTextField: UITextField?
    @IBOutlet weak var SubmittedByIdTextField: UITextField?
    @IBOutlet weak var SubmittedByUserTextField: UITextField?
    @IBOutlet weak var ModifiedByIdTextField: UITextField?
    @IBOutlet weak var ModifiedByUserTextField: UITextField?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.performAdditionalUICustomization()
        
        //TODO: Call a fetch request from userprofile to autofill profile page
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func performAdditionalUICustomization() {
        
    }
    
    func saveDraft() {
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
        
        let LGPSLatInt = Int((self.LGPSLatTextField?.text)!)!
        let LGPSLongInt = Int((self.LGPSLongTextField?.text)!)!
        let DistanceInKMInt = Int((self.DistanceInKMTextField?.text)!)!
        let UGPSLatInt = Int((self.UGPSLatTextField?.text)!)!
        let UGPSLongInt = Int((self.UGPSLongTextField?.text)!)!
        
        NetworkRequestManager.sharedInstance.execute(request: NetworkHelper.SaveDraft(
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
            ChargingCode: (self.ChargingCodeTextField?.text)!,
            StartingLoadDate: (self.StartingLoadDateTextField?.text)!,
            EndingLoadDate: (self.EndingLoadDateTextField?.text)!,
            StartingLoadTime: (self.StartingLoadTimeTextField?.text)!,
            EndingLoadTime: (self.EndingLoadTimeTextField?.text)!,
            LPersonInCharge: (self.LPersonInChargeTextField?.text)!,
            LPICAreaCodePhoneNumber: (self.LPICAreaCodePhoneNumberTextField?.text)!,
            LPICPhoneNumber: (self.LPICPhoneNumberTextField?.text)!,
            LLooadingLocationFrom: (self.LLooadingLocationFromTextField?.text)!,
            LLoadingLocationTo: (self.LLoadingLocationToTextField?.text)!,
            LState: (self.LStateTextField?.text)!,
            LDistrict: (self.LDistrictTextField?.text)!,
            LGPSLat: (LGPSLatInt),
            LGPSLong: (LGPSLongInt),
            DistanceInKM: (DistanceInKMInt),
            UnloadingDate: (self.UnloadingDateTextField?.text)!,
            UnloadingStartTime: (self.UnloadingStartTimeTextField?.text)!,
            UnloadingEndTime: (self.UnloadingEndTimeTextField?.text)!,
            UPersonInCharge: (self.UPersonInChargeTextField?.text)!,
            UPICAreaCodePhoneNumber: (self.UPICAreaCodePhoneNumberTextField?.text)!,
            UPICPhoneNumber: (self.UPICPhoneNumberTextField?.text)!,
            ULooadingLocationFrom: (self.ULooadingLocationFromTextField?.text)!,
            ULoadingLocationTo: (self.ULoadingLocationToTextField?.text)!,
            UState: (self.UStateTextField?.text)!,
            UDistrict: (self.UDistrictTextField?.text)!,
            UGPSLat: (UGPSLatInt),
            UGPSLong: (UGPSLongInt),
            VendorAssignedDateTime: (self.VendorAssignedDateTimeTextField?.text)!,
            Status: (self.StatusTextField?.text)!,
            CreatedDate: (self.CreatedDateTextField?.text)!,
            ModifiedDate: (self.ModifiedDateTextField?.text)!,
            SubmittedById: (self.SubmittedByIdTextField?.text)!,
            SubmittedByUser: (self.SubmittedByUserTextField?.text)!,
            ModifiedById: (self.ModifiedByIdTextField?.text)!,
            ModifiedByUser: (self.ModifiedByUserTextField?.text)!
            ), withEndpointClosure: endpointClosure) { result in
                
                switch result {
                case let .success(response):
                    self.dismissHud()
                    let infoDictionary = UserProfileResponseManager.sharedInstance.processUserProfileResponse(response: response)
                    if (infoDictionary["HAS_ERROR"] as? Bool == true) {
                        self.showAlert(title: "ERROR_TITLE_ERROR", message: infoDictionary["ERROR_MESSAGE"] as! String)
                    } else {
                        //TODO SOMETHING
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
