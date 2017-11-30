//
//  UserProfileManager.swift
//  Logistics
//
//  Created by Daniyal Ansari on 11/13/17.
//  Copyright © 2017 com.tnb. All rights reserved.
//

import Moya
import SwiftyJSON


class UserProfileResponseManager: BaseResponse {
    
    var userProfile: UserProfile?
    
    
    // MARK: - Singleton
    
    static let sharedInstance: UserProfileResponseManager = UserProfileResponseManager()
    private override init() {}
    
    
    // MARK: Class Methods
    
    func processUserProfileResponse(response: Response) -> Dictionary<String, Any> {
        
        var infoDictionary = Dictionary<String, Any>()
        infoDictionary["HAS_ERROR"] = false
        
        var (errorMessage, json) = self.checkForResponseError(response: response)
        if ((errorMessage.characters.count) > 0) {
            infoDictionary["HAS_ERROR"] = true
            infoDictionary["ERROR_MESSAGE"] = errorMessage
        } else {
            
            if (json != nil) {
                
                self.userProfile = UserProfile(fromDictionary: (json?["Response"])!)
                
            }
        }
        
        if (errorMessage.characters.count) > 0 {
            infoDictionary["HAS_ERROR"] = true
            infoDictionary["ERROR_MESSAGE"] = errorMessage
        }
        
        return infoDictionary
    }
    
}

