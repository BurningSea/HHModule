//
//  Node.swift
//  HHModule
//
//  Created by Howie on 26/6/20.
//  Copyright © 2020 Beijing Bitstar Technology Co., Ltd. All rights reserved.
//

import UIKit

protocol Dependency {
    func register(context: Context)
    func prepare()
}

class Module {
    let parentContext: Context
    fileprivate let dependencies: [(Context)->Module]
    internal lazy var context: Context = {
        let context = Context(parentContext)
        // 注入依赖
        for dep in dependencies {
            let depInstance = dep(context)
        }
        return context
    }()
    
    init(parentContext: Context, dependencies: [(Context)->Module] = []) {
        self.parentContext = parentContext
        self.dependencies = dependencies
        registerTo(context: parentContext)
    }
    
    func registerTo(context: Context) {
        
    }
}
