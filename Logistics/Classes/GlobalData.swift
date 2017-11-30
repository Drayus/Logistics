//
//  GlobalData.swift
//  Logistics
//
//  Created by Daniyal Ansari on 11/8/17.
//  Copyright © 2017 com.tnb. All rights reserved.
//

import UIKit

class GlobalData: NSObject {
    
    class var baseURL: String { return "http://35.165.83.248:8090/api" }
    //class var baseURL: String { return "http://localhost:43250/api" }
    
    
    // Authorization
    class var TNB_LOGISTICS_AUTHORIZATION_DATA: String { return "TNB_LOGISTICS_AUTHORIZATION_DATA" }
    
    
    // UserDefaults Keys
    class var USER_DEFAULTS_KEY_HAS_ONBOARDING_FLOW_SHOWN: String { return "USER_DEFAULTS_KEY_HAS_ONBOARDING_FLOW_SHOWN" }
    
}
