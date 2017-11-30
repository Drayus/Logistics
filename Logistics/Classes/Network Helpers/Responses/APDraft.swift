//
//  APDraft.swift
//  Logistics
//
//  Created by Daniyal Ansari on 11/21/17.
//  Copyright © 2017 com.tnb. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON

class APDraft: NSObject {
    
    //Profile Data
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
    var userId: String?
    
    //Loading Data
    var StartingLoadDate: String?
    var EndingLoadDate: String?
    var StartingLoadTime: String?
    var EndingLoadTime: String?
    var LPersonInCharge: String?
    var LPICAreaCodePhoneNumber: String?
    var LPICPhoneNumber: String?
    var LLooadingLocationFrom: String?
    var LLoadingLocationTo: String?
    var LState: String?
    var LDistrict: String?
    var LGPSLat: Int?
    var LGPSLong: Int?
    var DistanceInKM: Int?
    
    //Unloading Data
    var UnloadingDate: String?
    var UnloadingStartTime: String?
    var UnloadingEndTime: String?
    var UPersonInCharge: String?
    var UPICAreaCodePhoneNumber: String?
    var UPICPhoneNumber: String?
    var ULooadingLocationFrom: String?
    var ULoadingLocationTo: String?
    var UState: String?
    var UDistrict: String?
    var UGPSLat: Int?
    var UGPSLong: Int?
    
    //Task Data
    var VendorAssignedDateTime: String?
    var Status: String?
    var CreatedDate: String?
    var ModifiedDate: String?
    var SubmittedById: String?
    var SubmittedByUser: String?
    var ModifiedById: String?
    var ModifiedByUser: String?
    
    
    override init() {
        super.init()
    }
    
    
    init(fromDictionary dictionary: JSON) {
        
        //Profile Data
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
        self.userId = dictionary["userId"].string
        
        //Loading Data
        self.StartingLoadDate = dictionary["StartingLoadDate"].string
        self.EndingLoadDate = dictionary["EndingLoadDate"].string
        self.StartingLoadTime = dictionary["StartingLoadTime"].string
        self.EndingLoadTime = dictionary["EndingLoadTime"].string
        self.LPersonInCharge = dictionary["LPersonInCharge"].string
        self.LPICAreaCodePhoneNumber = dictionary["LPICAreaCodePhoneNumber"].string
        self.LPICPhoneNumber = dictionary["LPICPhoneNumber"].string
        self.LLooadingLocationFrom = dictionary["LLooadingLocationFrom"].string
        self.LLoadingLocationTo = dictionary["LLoadingLocationTo"].string
        self.LState = dictionary["LState"].string
        self.LDistrict = dictionary["LDistrict"].string
        self.LGPSLat = dictionary["LGPSLat"].int
        self.LGPSLong = dictionary["LGPSLong"].int
        self.DistanceInKM = dictionary["DistanceInKM"].int
        
        //Unloading Data
        self.UnloadingDate = dictionary["UnloadingDate"].string
        self.UnloadingStartTime = dictionary["UnloadingStartTime"].string
        self.UnloadingEndTime = dictionary["UnloadingEndTime"].string
        self.UPersonInCharge = dictionary["UPersonInCharge"].string
        self.UPICAreaCodePhoneNumber = dictionary["UPICAreaCodePhoneNumber"].string
        self.UPICPhoneNumber = dictionary["UPICPhoneNumber"].string
        self.ULooadingLocationFrom = dictionary["ULooadingLocationFrom"].string
        self.ULoadingLocationTo = dictionary["ULoadingLocationTo"].string
        self.UState = dictionary["UState"].string
        self.UDistrict = dictionary["UDistrict"].string
        self.UGPSLat = dictionary["UGPSLat"].int
        self.UGPSLong = dictionary["UGPSLong"].int
        
        //Task Data
        self.VendorAssignedDateTime = dictionary["VendorAssignedDateTime"].string
        self.Status = dictionary["Status"].string
        self.CreatedDate = dictionary["CreatedDate"].string
        self.ModifiedDate = dictionary["ModifiedDate"].string
        self.SubmittedById = dictionary["SubmittedById"].string
        self.SubmittedByUser = dictionary["SubmittedByUser"].string
        self.ModifiedById = dictionary["ModifiedById"].string
        self.ModifiedByUser = dictionary["ModifiedByUser"].string
        
    }
    
    
}
