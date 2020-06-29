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

    override func registerTo(context: Context) {
        context.register { () -> RootViewController in
            let rootVC = RootViewController()
            rootVC.dependencies = RootDepInjector(context: { [weak self] () -> Context in
                return self?.context ?? Context()
            })
            return rootVC
        }
    }
}
