//
//  BaseResponse.swift
//  Logistics
//
//  Created by Daniyal Ansari on 11/10/17.
//  Copyright © 2017 com.tnb. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON

class BaseResponse : NSObject {
    
    // MARK: Class Methods
    
    func checkForResponseError(response: Response) -> (String, JSON?) {
        var error:String = ""
        
        let json = try? JSON(response.mapJSON())
        if (json == nil) {
            error = NSLocalizedString("ERROR_MESSAGE_PROCESSING_RESPONSE", comment: "There was an error processing the response")
        } else {
            let success = json?["Success"] ?? false
            if (success == false) {
                let errorMessage = json?["ErrorMessage"].stringValue ?? ""
                if errorMessage.characters.count > 0 {
                    error = errorMessage
                } else {
                    error = NSLocalizedString("ERROR_MESSAGE_PROCESSING_RESPONSE", comment: "There was an error processing the response")
                }
            }
        }
        
        return (error, json)
    }
}
