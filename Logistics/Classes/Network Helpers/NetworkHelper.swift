//
//  NetworkHelper.swift
//  Logistics
//
//  Created by Daniyal Ansari on 11/8/17.
//  Copyright © 2017 com.tnb. All rights reserved.
//

import Foundation
import Moya
import Alamofire

public enum NetworkHelper {
    case Authentication( Username: String, Password: String )
    case RefreshToken( RefreshToken: String )
    case GetProfile
    case UpdateProfile( Id: Int, Username: String, Fullname: String, WorkAddress: String, OfficeNumberCityCode: String, OfficeNumber: String, HandPhoneNumberCityCode: String, HandPhoneNumber: String, FaxNumberCityCode: String, FaxNumber: String, CostCenter: String, BusinessArea: String, CompanyCode: String, ElementCost: String, ChargingCode: String )
    case GetLatestVersion
    case SaveDraft( Id: Int, Username: String, Fullname: String, WorkAddress: String, OfficeNumberCityCode: String, OfficeNumber: String, HandPhoneNumberCityCode: String, HandPhoneNumber: String, FaxNumberCityCode: String, FaxNumber: String, CostCenter: String, BusinessArea: String, CompanyCode: String, ElementCost: String, ChargingCode: String, StartingLoadDate: String, EndingLoadDate: String, StartingLoadTime: String, EndingLoadTime: String, LPersonInCharge: String, LPICAreaCodePhoneNumber: String, LPICPhoneNumber: String, LLooadingLocationFrom: String, LLoadingLocationTo: String, LState: String, LDistrict: String, LGPSLat: Int, LGPSLong: Int, DistanceInKM: Int, UnloadingDate: String, UnloadingStartTime: String, UnloadingEndTime: String, UPersonInCharge: String, UPICAreaCodePhoneNumber: String, UPICPhoneNumber: String, ULooadingLocationFrom: String, ULoadingLocationTo: String, UState: String, UDistrict: String, UGPSLat: Int, UGPSLong: Int, VendorAssignedDateTime: String, Status: String, CreatedDate: String, ModifiedDate: String, SubmittedById: String, SubmittedByUser: String, ModifiedById: String, ModifiedByUser: String )
    case GetAPForm
    //case GetAPFormDraft
}

extension NetworkHelper: TargetType {
    
    public var baseURL: URL { return URL(string: GlobalData.baseURL)! }
    static var authorizationBasicValue: String { return "Basic NDJmZjVkYWQzYzI3NGM5N2EzYTdjM2Q0NGI2N2JiNDI6Y2xpZW50MTIzNDU2" }
    
    public var path: String {
        switch self{
        case .Authentication:
            return "/Authentication/GetToken"
        case .RefreshToken:
            return "/Authentication/RefreshToken"
        case .GetProfile:
            return "/UserProfileApi/GetProfile"
        case .UpdateProfile:
            return "/UserProfileApi/UpdateProfile"
        case .GetLatestVersion:
            return "/AppVersion/GetLatestVersion"
        case .SaveDraft:
            return "/APForm/SaveDraft"
        case .GetAPForm:
            return "/APForm/GetAPForm"
        //case .GetAPFormDraft:
          //  return ""
        }
    }
    
    public var method: Moya.Method {
        switch self{
        case .Authentication:
            return .post
        case .RefreshToken:
            return .post
        case .GetProfile:
            return .get
        case .UpdateProfile:
            return .post
        case .GetLatestVersion:
            return .get
        case .SaveDraft:
            return .post
        case .GetAPForm:
            return .get
        }
    }
    
    public var task: Task {
        switch self{
        case .Authentication(let Username, let Password):
            return .requestParameters(parameters: ["Username": Username, "Password": Password], encoding: JSONEncoding.default)
        case .RefreshToken(let RefreshToken):
            return .requestParameters(parameters: ["RefreshToken": RefreshToken], encoding: JSONEncoding.default)
            
        case .UpdateProfile(let Id, let Username, let Fullname, let WorkAddress, let OfficeNumberCityCode, let OfficeNumber, let HandPhoneNumberCityCode, let HandPhoneNumber, let FaxNumberCityCode, let FaxNumber, let CostCenter, let BusinessArea, let CompanyCode, let ElementCost, let ChargingCode):
            return .requestParameters(parameters: ["Id": Id, "Username": Username, "Fullname": Fullname, "WorkAddress": WorkAddress, "OfficeNumberCityCode": OfficeNumberCityCode, "OfficeNumber": OfficeNumber, "HandPhoneNumberCityCode": HandPhoneNumberCityCode, "HandPhoneNumber": HandPhoneNumber, "FaxNumberCityCode": FaxNumberCityCode, "FaxNumber": FaxNumber, "CostCenter": CostCenter, "BusinessArea": BusinessArea, "CompanyCode": CompanyCode, "ElementCost": ElementCost, "ChargingCode": ChargingCode], encoding: JSONEncoding.default)
            
        case .SaveDraft( let Id, let Username, let Fullname, let WorkAddress, let OfficeNumberCityCode, let OfficeNumber, let HandPhoneNumberCityCode, let HandPhoneNumber, let FaxNumberCityCode, let FaxNumber, let CostCenter, let BusinessArea, let CompanyCode, let ElementCost, let ChargingCode, let StartingLoadDate, let EndingLoadDate, let StartingLoadTime, let EndingLoadTime, let LPersonInCharge, let LPICAreaCodePhoneNumber, let LPICPhoneNumber, let LLooadingLocationFrom, let LLoadingLocationTo, let LState, let LDistrict, let LGPSLat, let LGPSLong, let DistanceInKM, let UnloadingDate, let UnloadingStartTime, let UnloadingEndTime, let UPersonInCharge, let UPICAreaCodePhoneNumber, let UPICPhoneNumber, let ULooadingLocationFrom, let ULoadingLocationTo, let UState, let UDistrict, let UGPSLat, let UGPSLong, let VendorAssignedDateTime, let Status, let CreatedDate, let ModifiedDate, let SubmittedById, let SubmittedByUser, let ModifiedById, let ModifiedByUser ):
            return .requestParameters( parameters: ["Id": Id, "Username": Username, "Fullname": Fullname, "WorkAddress": WorkAddress, "OfficeNumberCityCode": OfficeNumberCityCode, "OfficeNumber": OfficeNumber, "HandPhoneNumberCityCode": HandPhoneNumberCityCode, "HandPhoneNumber": HandPhoneNumber, "FaxNumberCityCode": FaxNumberCityCode, "FaxNumber": FaxNumber, "CostCenter": CostCenter, "BusinessArea": BusinessArea, "CompanyCode": CompanyCode, "ElementCost": ElementCost, "ChargingCode": ChargingCode,  "StartingLoadDate": StartingLoadDate, "EndingLoadDate": EndingLoadDate, "StartingLoadTime": StartingLoadTime, "EndingLoadTime": EndingLoadTime, "LPersonInCharge": LPersonInCharge, "LPICAreaCodePhoneNumber": LPICAreaCodePhoneNumber, "LPICPhoneNumber": LPICPhoneNumber, "LLooadingLocationFrom": LLooadingLocationFrom, "LLoadingLocationTo": LLoadingLocationTo, "LState": LState, "LDistrict": LDistrict, "LGPSLat": LGPSLat, "LGPSLong": LGPSLong, "DistanceInKM": DistanceInKM, "UnloadingDate": UnloadingDate, "UnloadingStartTime": UnloadingStartTime, "UnloadingEndTime": UnloadingEndTime, "UPersonInCharge": UPersonInCharge, "UPICAreaCodePhoneNumber": UPICAreaCodePhoneNumber, "UPICPhoneNumber": UPICPhoneNumber, "ULooadingLocationFrom": ULooadingLocationFrom, "ULoadingLocationTo": ULoadingLocationTo, "UState": UState, "UDistrict": UDistrict, "UGPSLat": UGPSLat, "UGPSLong": UGPSLong, "VendorAssignedDateTime": VendorAssignedDateTime, "Status": Status, "CreatedDate": CreatedDate, "ModifiedDate": ModifiedDate, "SubmittedById": SubmittedById, "SubmittedByUser": SubmittedByUser, "ModifiedById": ModifiedById, "ModifiedByUser": ModifiedByUser], encoding: JSONEncoding.default )
            
        default:
            return .requestPlain
        }
    }
    
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    public var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }

}



// MARK: - Helpers
private extension String {
    var urlEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8EncodedData: Data {
        return self.data(using: .utf8)!
    }
}

