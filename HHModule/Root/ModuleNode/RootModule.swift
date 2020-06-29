//
//  RootNode.swift
//  HHModule
//
//  Created by Howie on 26/6/20.
//  Copyright © 2020 Beijing Bitstar Technology Co., Ltd. All rights reserved.
//

import UIKit

class RootModule: Module {
    init(parentContext: Context) {
        super.init(parentContext: parentContext, dependencies: [{
                VC1Module(parentContext: $0)
            },
            {
                VC2Module(parentContext: $0)
            },
            {
                Service1Module(parentContext: $0)
            },
            {
                Service2Module(parentContext: $0)
            },
        ])
    }

//    override func registerTo(context: Context) {
//        context.register { () -> RootViewController in
//            let rootVC = RootViewController()
//            rootVC.weakDependencies = RootDepInjector(context: { [weak self] () -> Context in
//                return self?.context ?? Context()
//            })
//            return rootVC
//        }
//    }
}

import Promises

class PRoot {
    init(_ context: Context) {
        // Root强依赖于Service2，即调用root的能力时Service2必须已经初始化好
        // Root调用VC1、VC2、Service1，可以懒加载
        let rootPromise = Promise { [weak context] in
            
        }
    }
}
