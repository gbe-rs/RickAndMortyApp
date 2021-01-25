//
//  HomeViewModel.swift
//  Challenge
//
//  Created by Gabriel Ribeiro dos Santos on 18/01/21.
//  Copyright © 2021 Gabriel Ribeiro dos Santos. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    //MARK: Variables
    
    let showErrorMessage: Observable <NSError?> = Observable(nil)
    let showEmptyLabel: Observable <Bool> = Observable(false)
    let showLoading: Observable <Bool> = Observable(false)
    let charachters: Observable <[Charachter]> =  Observable([])
    let dataObserver: Observable <[Int]> = Observable([])
    
    var data: [Int] = []
    private let request = CharachtersRequest()
    
    //MARK: Functions
    
    public func initViewModel() {
        self.getCharachters(false)
    }
    
    private func getCharachters(_ isUpdate: Bool) {
        self.showLoading.value = true
        self.showEmptyLabel.value = false
        
        self.request.getCharachters( success: { (charachters) in
            if let char = charachters {
                if (char.charachters?.count ?? 0) > 0 {
                    if let charachters = char.charachters {
                        self.charachters.value = charachters
                    }
                }
            } else {
                self.charachters.value = []
                self.showEmptyLabel.value = true
            }
            
            self.showLoading.value = false
            self.dataObserver.value = self.data
        }) { (restError) in
            self.showLoading.value = false
            self.showErrorMessage.value = restError
        }
    }
    
    public func updateCharachters(){
        self.getCharachters(true)
    }
}
