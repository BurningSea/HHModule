//
//  VC2Builder.swift
//  HHModule
//
//  Created by Howie on 26/6/20.
//  Copyright © 2020 Beijing Bitstar Technology Co., Ltd. All rights reserved.
//

import UIKit

class VC2Builder: NSObject, Builder {
    typealias TargetType = VC2
    
    var name = "VC2"
    
    func build() -> VC2 {
        let vc = VC2()
        vc.title = name
        return vc
    }
}
