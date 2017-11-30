//
//  AuthenticationResponseManager.swift
//  Logistics
//
//  Created by Daniyal Ansari on 11/10/17.
//  Copyright © 2017 com.tnb. All rights reserved.
//

import Moya
import SwiftyJSON

class AuthenticationResponseManager : BaseResponse {
    
    //Singelton
    static let sharedInstance: AuthenticationResponseManager = AuthenticationResponseManager()
    private override init() { }
    
    
    func processAuthenticationResponse(response: Response) -> Dictionary<String, Any> {
        
        var infoDictionary = Dictionary<String, Any>()
        infoDictionary["HAS_ERROR"] = false
        
        var errorMessage:String = ""
        let json = try? JSON(response.mapJSON())
        if (json == nil) {
            errorMessage = NSLocalizedString("ERROR_MESSAGE_PROCESSING_RESPONSE", comment: "There was an error processing the response")
        } else {
            
            let success = json?["Success"] ?? false
            if (success == false) {
                errorMessage = NSLocalizedString("ERROR_MESSAGE_INVALID_GRANT", comment: "Invalid grant")
            } else {
                let error = json?["Response"]["error"].stringValue ?? ""
                if error.characters.count > 0 {
                    if error == "invalid_grant" {
                        errorMessage = NSLocalizedString("ERROR_MESSAGE_INVALID_GRANT", comment: "Invalid grant")
                    }
                } else {
                    
                    let accessToken = json?["Response"]["access_token"].stringValue ?? ""
                    if accessToken.characters.count > 0 {
                        
                        var authorizationData:AuthorizationData!
                        let userDefaults = UserDefaults.standard
                        if (userDefaults.object(forKey: GlobalData.TNB_LOGISTICS_AUTHORIZATION_DATA) != nil) {
                            let decodedData  = userDefaults.object(forKey: GlobalData.TNB_LOGISTICS_AUTHORIZATION_DATA) as! NSData
                            if decodedData.length > 0 {
                                authorizationData = NSKeyedUnarchiver.unarchiveObject(with: decodedData as Data) as! AuthorizationData
                            }
                        } else {
                            authorizationData = AuthorizationData()
                        }
                        
                        let token_type = json?["Response"]["token_type"].stringValue ?? ""
                        let expires_in = json?["Response"]["expires_in"].stringValue ?? ""
                        let refresh_token = json?["Response"]["refresh_token"].stringValue ?? ""
                        
                        authorizationData.access_token = accessToken
                        authorizationData.token_type = token_type
                        authorizationData.expires_in = expires_in
                        authorizationData.refresh_token = refresh_token
                        self.saveAuthorizationData(authorizationData: authorizationData)
                        
                    }
                }
            }
            
        }
        
        if (errorMessage.characters.count) > 0 {
            infoDictionary["HAS_ERROR"] = true
            infoDictionary["ERROR_MESSAGE"] = errorMessage
        }
        
        return infoDictionary
    }
    
    
    
    // Save Settings
    func saveAuthorizationData(authorizationData:AuthorizationData) {
        
        let userDefaults = UserDefaults.standard
        let encodedContent = NSKeyedArchiver.archivedData(withRootObject: authorizationData)
        userDefaults.set(encodedContent, forKey: GlobalData.TNB_LOGISTICS_AUTHORIZATION_DATA)
        userDefaults.synchronize()
        
    }
    
    // Fetch Access Token
    func fetchAccessToken() -> String! {
        
        var accessToken:String!
        
        let userDefaults = UserDefaults.standard
        if (userDefaults.object(forKey: GlobalData.TNB_LOGISTICS_AUTHORIZATION_DATA) != nil) {
            let decodedData  = userDefaults.object(forKey: GlobalData.TNB_LOGISTICS_AUTHORIZATION_DATA) as! NSData
            if decodedData.length > 0 {
                let authorizationData = NSKeyedUnarchiver.unarchiveObject(with: decodedData as Data) as! AuthorizationData
                accessToken = authorizationData.access_token
            }
        }
        
        print(accessToken);
        
        return accessToken
        
    }
    
    // Fetch Refresh Token
    func fetchRefreshToken() -> String! {
        
        var refreshToken:String!
        
        let userDefaults = UserDefaults.standard
        if (userDefaults.object(forKey: GlobalData.TNB_LOGISTICS_AUTHORIZATION_DATA) != nil) {
            let decodedData  = userDefaults.object(forKey: GlobalData.TNB_LOGISTICS_AUTHORIZATION_DATA) as! NSData
            if decodedData.length > 0 {
                let authorizationData = NSKeyedUnarchiver.unarchiveObject(with: decodedData as Data) as! AuthorizationData
                refreshToken = authorizationData.refresh_token
            }
        }
        
        return refreshToken
        
    }


}
