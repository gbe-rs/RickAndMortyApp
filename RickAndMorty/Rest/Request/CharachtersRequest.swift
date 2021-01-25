//
//  CharachtersRequest.swift
//  Challenge
//
//  Created by Gabriel Ribeiro dos Santos on 19/01/21.
//  Copyright © 2021 Gabriel Ribeiro dos Santos. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper
import Alamofire


class CharachtersRequest {
    
    //MARK: Variables
    
    var request: [String: DataRequest] = [:]
    var url = "https://rickandmortyapi.com/api/character"
    
    //MARK: Variables
    
    func getCharachters(  success:@escaping (_ charachters: Charachters?) -> Void , error: @escaping (_ error: RestError?) -> Void) {
        let key = "getChar"
        
        if let request = self.request[key] {
            request.cancel()
            self.request.removeValue(forKey: key)
        }
        
        self.request[key] = Http.get(url: url) { (char: Charachters?, errorRes) in
            guard errorRes?.statusCode == nil else{
                if errorRes?.statusCode != -999 {
                    error(errorRes)
                }
                return
            }
            success(char)
        }
    }
    
}
