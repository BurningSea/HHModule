//
//  Promise.swift
//  HHModule
//
//  Created by Howie on 28/6/20.
//  Copyright © 2020 Beijing Bitstar Technology Co., Ltd. All rights reserved.
//

import Foundation

enum AwaitResult<V, E> {
    case Value(V)
    case Error(E)
}

protocol Promise {
    associatedtype Value
    associatedtype Err = Error
    func then<P: Promise>(_ preferQueue: DispatchQueue?,
                          _ thenWork: (Value) -> (P.Value)) -> P where P.Err == Err
    func `catch`(_ preferQueue: DispatchQueue?,
                 _ catchWork: (Err) -> Void)
    
    func await(_ preferQueue: DispatchQueue?) -> AwaitResult<Value, Err>
}

extension Promise {
    func then<P: Promise>(_ thenWork: (Value) -> (P.Value)) -> P where P.Err == Err {
        return then(nil, thenWork)
    }
    
    func `catch`(_ catchWork: (Err) -> Void) {
        return `catch`(nil, catchWork)
    }
    
    func await() -> AwaitResult<Value, Err> {
        return await(nil)
    }
}

