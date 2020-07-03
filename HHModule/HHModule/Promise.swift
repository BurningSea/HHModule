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

protocol AnyPromise {
    associatedtype Value
    associatedtype Err = Error
    mutating func pthen<P: AnyPromise>(_ preferQueue: DispatchQueue?,
                          _ thenWork: @escaping (Value) -> (P.Value)) -> P where P.Err == Err
    mutating func pcatch(_ preferQueue: DispatchQueue?,
                 _ catchWork: @escaping (Err) -> Void)
    
    mutating func pawait(_ preferQueue: DispatchQueue?) -> AwaitResult<Value, Err>
}

extension AnyPromise {
    mutating func pthen<P: AnyPromise>(_ thenWork: @escaping (Value) -> (P.Value)) -> P where P.Err == Err {
        return pthen(nil, thenWork)
    }
    
    mutating func pcatch(_ catchWork: @escaping (Err) -> Void) {
        return pcatch(nil, catchWork)
    }
    
    mutating func pawait() -> AwaitResult<Value, Err> {
        return pawait(nil)
    }
}

