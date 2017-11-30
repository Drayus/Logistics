//
//  Document.swift
//  Logistics
//
//  Created by Daniyal Ansari on 11/1/17.
//  Copyright © 2017 com.tnb. All rights reserved.
//

import UIKit

class Document: UIDocument {
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
    }
}

