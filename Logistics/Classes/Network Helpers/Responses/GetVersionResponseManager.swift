//
//  GetVersionResponseManager.swift
//  Logistics
//
//  Created by Daniyal Ansari on 11/20/17.
//  Copyright © 2017 com.tnb. All rights reserved.
//

import Moya
import SwiftyJSON

class GetVersionResponseManager: BaseResponse {
    
    var AppVersion: GetVersion?
    
    
    // MARK: - Singleton
    
    static let sharedInstance: GetVersionResponseManager = GetVersionResponseManager()
    private override init() {}
    
    
    // MARK: Class Methods
    
    func processGetVersionResponse(response: Response) -> Dictionary<String, Any> {
        
        var infoDictionary = Dictionary<String, Any>()
        infoDictionary["HAS_ERROR"] = false
        
        var (errorMessage, json) = self.checkForResponseError(response: response)
        if ((errorMessage.characters.count) > 0) {
            infoDictionary["HAS_ERROR"] = true
            infoDictionary["ERROR_MESSAGE"] = errorMessage
        } else {
            
            if (json != nil) {
                
                self.AppVersion = GetVersion(fromDictionary: (json?["Response"])!)
                
            }
        }
        
        if (errorMessage.characters.count) > 0 {
            infoDictionary["HAS_ERROR"] = true
            infoDictionary["ERROR_MESSAGE"] = errorMessage
        }
        
        return infoDictionary
    }
    
}
