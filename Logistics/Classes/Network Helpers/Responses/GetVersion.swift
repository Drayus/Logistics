//
//  GetVersion.swift
//  Logistics
//
//  Created by Daniyal Ansari on 11/20/17.
//  Copyright © 2017 com.tnb. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetVersion: NSObject {
    
    var CurrentVersion: String?
    var LatestVersion: String?
    var ReleaseNotes: String?
    var AppUrl: String?
    
    override init() {
        super.init()
    }
    
    
    init(fromDictionary dictionary: JSON) {
        
        self.CurrentVersion = dictionary["CurrentVersion"].string
        self.LatestVersion = dictionary["LatestVersion"].string
        self.ReleaseNotes = dictionary["ReleaseNotes"].string
        self.AppUrl = dictionary["AppUrl"].string
    }
    
}
