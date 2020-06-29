//
//  NodeService1.swift
//  HHModule
//
//  Created by Howie on 26/6/20.
//  Copyright © 2020 Beijing Bitstar Technology Co., Ltd. All rights reserved.
//

import UIKit

class Service1Module: Module {
    override func registerTo(context: Context) {
        context.register(instance: Service1())
    }
}
