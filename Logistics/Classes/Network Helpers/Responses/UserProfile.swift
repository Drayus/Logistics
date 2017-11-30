//
//  UserProfile.swift
//  Logistics
//
//  Created by Daniyal Ansari on 11/13/17.
//  Copyright © 2017 com.tnb. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserProfile: NSObject {
    
    var Id: Int?
    var Username: String?
    var Fullname: String?
    var WorkAddress: String?
    var OfficeNumberCityCode: String?
    var OfficeNumber: String?
    var HandPhoneNumberCityCode: String?
    var HandPhoneNumber: String?
    var FaxNumberCityCode: String?
    var FaxNumber: String?
    var CostCenter: String?
    var BusinessArea: String?
    var CompanyCode: String?
    var ElementCost: String?
    var ChargingCode: String?
    var UserID: String?
    
    
    override init() {
        super.init()
    }
    
    
    init(fromDictionary dictionary: JSON) {
        
        self.Id = dictionary["Id"].int
        self.Username = dictionary["Username"].string
        self.Fullname = dictionary["Fullname"].string
        self.WorkAddress = dictionary["WorkAddress"].string
        self.OfficeNumberCityCode = dictionary["OfficeNumberCityCode"].string
        self.OfficeNumber = dictionary["OfficeNumber"].string
        self.HandPhoneNumberCityCode = dictionary["HandPhoneNumberCityCode"].string
        self.HandPhoneNumber = dictionary["HandPhoneNumber"].string
        self.FaxNumberCityCode = dictionary["FaxNumberCityCode"].string
        self.FaxNumber = dictionary["FaxNumber"].string
        self.CostCenter = dictionary["CostCenter"].string
        self.BusinessArea = dictionary["BusinessArea"].string
        self.CompanyCode = dictionary["CompanyCode"].string
        self.ElementCost = dictionary["ElementCost"].string
        self.ChargingCode = dictionary["ChargingCode"].string
        self.UserID = dictionary["UserID"].string
    }
}

