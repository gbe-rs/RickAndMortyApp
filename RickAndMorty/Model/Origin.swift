//
//  Origin.swift
//  RickAndMorty
//
//  Created by Gabriel Ribeiro dos Santos on 21/01/21.
//  Copyright © 2021 Gabriel Ribeiro dos Santos. All rights reserved.
//

import Foundation
import ObjectMapper

class Origin: Mappable {
   
    var name: String?
    var url: String?
    
    init(){}
    
    required init?(map: Map) {
        self.mapping(map: map)
    }
    
    func mapping(map: Map) {
        name              <- map["name"]
        url            <- map["url"]
    }
}
