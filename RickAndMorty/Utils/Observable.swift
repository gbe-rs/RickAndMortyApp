//
//  Observable.swift
//  Challenge
//
//  Created by Gabriel Ribeiro dos Santos on 19/01/21.
//  Copyright © 2021 Gabriel Ribeiro dos Santos. All rights reserved.
//

import Foundation

public class Observable<ObservedType> {
    
    public typealias Observer = (_ observable: Observable<ObservedType>, ObservedType) -> Void
    private var observers: [Observer]
    
    public var value: ObservedType {
        didSet {
            notifyObservers(value)
        }
    }
    
    public init(_ value: ObservedType) {
        self.value = value
        observers = []
    }
    
    public func observe(observer: @escaping Observer) {
        self.observers.append(observer)
    }
    
    private func notifyObservers(_ value: ObservedType) {
        self.observers.forEach { [unowned self](observer) in
            observer(self, value)
        }
    }
    
}
