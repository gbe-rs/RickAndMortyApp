//
//  ErrorManager.swift
//  Challenge
//
//  Created by Gabriel Ribeiro dos Santos on 19/01/21.
//  Copyright © 2021 Gabriel Ribeiro dos Santos. All rights reserved.
//

import Foundation
import UIKit

class ErrorManager{
 
    //MARK: Variables
    
    static let sharedInstance = ErrorManager()

      var alertController: UIAlertController!
      var alertAction: UIAlertAction?
    
    //MARK: Functions
    
    func showErrorMessageDefault(_ error:NSError, action: UIAlertAction?)-> UIAlertController {
        alertAction = action
        manageErrors(error)
        return alertController
    }
    
    //MARK: Private Functions
    
    fileprivate func manageErrors(_ error: NSError) {
        
        switch error.code {
        default:
            var errorMessage = error.localizedDescription
            
            if errorMessage.contains("#") {
                let messageArray = errorMessage.components(separatedBy: "#")
                if messageArray.count > 2 {
                    
                    let codeS = messageArray[0]
                    let codeD = Double(codeS)
                    
                    if(codeD == 0) {
                        let errorCode = messageArray[1].components(separatedBy: "-")
                        errorMessage = "Ocorreu um erro desconhecido. COD:" + errorCode[0]
                    }
                    else {
                        errorMessage = messageArray[2]
                    }
                }
            }
            else {
                errorDefault("ALERT_ERROR_TITLE", message: errorMessage)
            }
        }
    }
    
    fileprivate func errorDefault(_ title: String, message: String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert);
        
        if let alertAction = alertAction{
            alertController.addAction(alertAction)
        }else{
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) -> Void in
            }
            alertController.addAction(okAction)
        }
    }
    
}
