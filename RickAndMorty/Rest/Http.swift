//
//  Http.swift
//  Challenge
//
//  Created by Gabriel Ribeiro dos Santos on 19/01/21.
//  Copyright © 2021 Gabriel Ribeiro dos Santos. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON
import ObjectMapper

class Http{
    
    typealias onComplete<T: Mappable> = (_ object: T?, _ error: RestError?) -> Void
    
    enum StatusRequest {
        case success
        case error
        case canceled
        
        init(code:Int){
            switch code {
            case -999: self = .canceled
            case 100 ..< 400: self = .success
            case 400 ..< 600: self = .error
            default: self = .error
            }
        }
        
        func isSuccess() -> Bool{
            switch self {
            case .success:
                return true
            default:
                return false
            }
        }
        
    }
    
    static func get<T: Mappable>(url: String, onComplete: @escaping onComplete<T>) -> DataRequest {
        return request(method: .get, url: url, parameters: nil, encoding: URLEncoding.default, onComplete: onComplete)
    }
    
    static func request<T: Mappable>(method: HTTPMethod ,url: String, parameters: [String : AnyObject]?, encoding: ParameterEncoding, onComplete: @escaping onComplete<T>) -> DataRequest {
        
        return Alamofire.SessionManager.default.request(url, method: method, parameters: parameters, encoding: encoding, headers: nil).responseObject { (response: DataResponse<T>) in
            debugPrint("##############################################################################")
            debugPrint("    URL:        \(url)")
            debugPrint("    Parameters: \(String(describing: parameters))")
            debugPrint("    Alamofire response:     \(response)")
            debugPrint("    Alamofire statusCode:   \(response.response?.statusCode ?? 0)")
            debugPrint("    Success:                \(response.result.isSuccess)")
            debugPrint("##############################################################################")
            
            let res = StatusRequest(code: response.response?.statusCode ?? 400)
            
            guard res.isSuccess() else {
                var error = response.error
                if let error = response.error as NSError?, error.code == -999 { //Cancelled
                    return
                }
                
                if response.response?.statusCode == 500 {
                    error = RestError("Ocorreu um erro inesperado no servidor.", 500)
                }
                onComplete(nil, getRestError(response: response.response, data: response.data, error: error))
                return
            }
            onComplete(response.result.value, nil)
        }
        
    }
    
    static func getRestError(response: HTTPURLResponse?, data: Data?, error: Error? = nil) -> RestError {
        let errorStatusCode = response?.statusCode ?? error?._code ?? 0
        var errorMsg = error?.localizedDescription ?? "Houve um erro desconhecido"
        
        if(error?._code == -1009) {
            return RestError("Sem conexão com a internet", 1009)
        }
        
        guard data != nil else {
            return RestError(errorMsg, errorStatusCode)
        }
        
        guard var json = try? JSON(data: data!) else {
            let stringData = String(data: data!, encoding: .utf8)
            guard ((stringData?.contains("<html"))!) && (stringData != "null") else {
                errorMsg = (stringData?.isEmpty)! ? errorMsg: stringData!
                return RestError(errorMsg, errorStatusCode)
            }
            return RestError(errorMsg, errorStatusCode)
        }
        
        if json["message"].description != "null"{
            errorMsg = json["message"].description
            json.dictionaryObject?.removeValue(forKey: "message")
        }
        
        if json["error_description"].description != "null"{
            errorMsg = json["error_description"].description
            json.dictionaryObject?.removeValue(forKey: "error_description")
        }
        let restError = RestError(errorMsg, errorStatusCode)
        restError.extra = json
        
        return restError
        
    }
    
}
