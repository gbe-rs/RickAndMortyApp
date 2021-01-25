//
//  RestError.swift
//  Challenge
//
//  Created by Gabriel Ribeiro dos Santos on 19/01/21.
//  Copyright © 2021 Gabriel Ribeiro dos Santos. All rights reserved.
//

import UIKit
import SwiftyJSON

class RestError: NSError {
    
    var message: String = ""
    var codeStr: String?
    var statusCode: Int = 0
    var extra: JSON?
    
    init(_ message: String, _ statusCode: Int = 0) {
        super.init(domain: NSStringFromClass(type(of: self)), code: statusCode, userInfo: [NSLocalizedDescriptionKey: message])
        
        self.message = message
        self.statusCode = statusCode
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

