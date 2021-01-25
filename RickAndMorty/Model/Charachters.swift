//
//  Charachters.swift
//  Challenge
//
//  Created by Gabriel Ribeiro dos Santos on 19/01/21.
//  Copyright © 2021 Gabriel Ribeiro dos Santos. All rights reserved.
//

import Foundation
import ObjectMapper

class Charachters: NSObject, Mappable {
    
    var charachters: [Charachter]?
    
    override init() {
        super.init()
        self.charachters = [Charachter]()
    }
    
    init(dictionary: Dictionary<String, AnyObject>) {
        
        let charVOS = NSMutableArray()
        if ( (dictionary["results"] != nil) && !(dictionary["results"] is NSNull) ){
            let recipientsArr:Array = (dictionary["results"]?.allObjects)!
            if recipientsArr.count > 0 {
                for (_, value) in recipientsArr.enumerated() {
                    charVOS.add(Charachters(map: value as! Map)!)
                }
            }
        }
        self.charachters = charVOS as NSArray as? [Charachter]
    }
    
    required init?(map: Map) {
        super.init()
        self.mapping(map: map)
    }
    
    func mapping(map: Map) {
        charachters                   <- map["results"]
    }
}
