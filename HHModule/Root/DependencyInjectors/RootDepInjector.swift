//
//  RootDepInjector.swift
//  HHModule
//
//  Created by Howie on 26/6/20.
//  Copyright © 2020 Beijing Bitstar Technology Co., Ltd. All rights reserved.
//

import UIKit

class RootDepInjector: NSObject, RootDependencies {
    fileprivate var context: () -> Context
    
    init(context: @escaping ()-> Context) {
        self.context = context
    }
    
    func vc1() -> VC1 {
        let recipie: VC1? = context().service()
        return recipie!
    }
    
    func vc2() -> VC2 {
        let builder: VC2Builder? = context().builder()
        builder?.name = "Tuned VC2"
        return (builder?.build())!
    }
    
    func service1() -> Service1 {
        let service: Service1? = context().service()
        return service!
    }
    
    func service2() -> IService2 {
        let service: IService2? = context().cached.service()
        return service!
    }
    
    func service21() -> Service21 {
        let service: Service21? = context().service()
        return service!
    }
}
