//
//  Service2Module.swift
//  HHModule
//
//  Created by Howie on 26/6/20.
//  Copyright © 2020 Beijing Bitstar Technology Co., Ltd. All rights reserved.
//

import UIKit

class Service2Module: Module {
    override func registerTo(context: Context) {
        let service2: () -> IService2 = {
            return Service2()
        }
        var registry = context.registry {
            print("Service2 Prepared")
        }
        registry.register(recipe: service2)
        registry.register(instance: Service21())
    }
}
