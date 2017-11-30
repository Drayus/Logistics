//
//  AuthorizationData.swift
//  Logistics
//
//  Created by Daniyal Ansari on 11/10/17.
//  Copyright © 2017 com.tnb. All rights reserved.
//

import UIKit

class AuthorizationData: NSObject, NSCoding {
    
    var access_token = ""
    var token_type = ""
    var expires_in = ""
    var refresh_token = ""
    
    
    override init() {
        super.init()
    }
    
    // These encode and decode methods to convert the model into key-value mapped object, enabling the developer to save it to the disk
    @objc required init(coder aDecoder: NSCoder) {
        
        access_token = (aDecoder.decodeObject(forKey: "access_token") as? String)!
        token_type = (aDecoder.decodeObject(forKey: "token_type") as? String)!
        expires_in = (aDecoder.decodeObject(forKey: "expires_in") as? String)!
        refresh_token = (aDecoder.decodeObject(forKey: "refresh_token") as? String)!
        
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(token_type, forKey: "token_type")
        aCoder.encode(expires_in, forKey: "expires_in")
        aCoder.encode(refresh_token, forKey: "refresh_token")
    }
}
