//
//  Charachters.swift
//  Challenge
//
//  Created by Gabriel Ribeiro dos Santos on 19/01/21.
//  Copyright © 2021 Gabriel Ribeiro dos Santos. All rights reserved.
//

import Foundation
import ObjectMapper

class Charachter: Mappable {
   
    var charId: Int?
    var charName: String?
    var status: String?
    var species: String?
    var gender: String?
    var image: String?
    var origin: Origin?
    var location: Location?
    
    init(){}
    
    required init?(map: Map) {
        self.mapping(map: map)
    }
    
    func mapping(map: Map) {
        charId              <- map["id"]
        charName            <- map["name"]
        status              <- map["status"]
        species             <- map["species"]
        gender              <- map["gender"]
        image               <- map["image"]
        origin              <- map["origin"]
        location            <- map["location"]
    }
}
