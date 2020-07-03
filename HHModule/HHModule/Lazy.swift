//
//  Lazy.swift
//  HHModule
//
//  Created by Howie He on 2020/7/3.
//  Copyright © 2020 Beijing Bitstar Technology Co., Ltd. All rights reserved.
//

import Foundation

struct Lazy<T> {
    lazy var value = creator()
    var creator: () -> T
}

extension Lazy : AnyPromise where T: AnyPromise {
    typealias Value = T.Value
    typealias Err = T.Err
    
    mutating func pawait(_ preferQueue: DispatchQueue?) -> AwaitResult<T.Value, T.Err> {
        self.value.pawait(preferQueue)
    }
    
    mutating func pcatch(_ preferQueue: DispatchQueue?, _ catchWork: @escaping (T.Err) -> Void) {
        self.value.pcatch(preferQueue, catchWork)
    }
    
    mutating func pthen<P>(_ preferQueue: DispatchQueue?, _ thenWork: @escaping (T.Value) -> (P.Value)) -> P where P : AnyPromise, Self.Err == P.Err {
        self.value.pthen(preferQueue, thenWork)
    }
}

import Promises

extension Promise : AnyPromise {
    typealias Err = Error
    
    func pawait(_ preferQueue: DispatchQueue?) -> AwaitResult<Value, Err> {
        do {
            let val = try await(self)
            return .Value(val)
        } catch let err {
            return .Error(err as Promise<Value>.Err)
        }
    }
    
    func pcatch(_ preferQueue: DispatchQueue?, _ catchWork: @escaping (Err) -> Void) {
        if let queue = preferQueue {
            self.catch(on: queue, catchWork)
        } else {
            self.catch(catchWork)
        }
    }
    
    func pthen<P>(_ preferQueue: DispatchQueue?, _ thenWork: @escaping (Value) -> (P.Value)) -> P where P : AnyPromise, P.Err == Err {
        if let queue = preferQueue {
            return self.then(on: queue, thenWork) as! P
        } else {
            return self.then(thenWork) as! P
        }
    }
}
