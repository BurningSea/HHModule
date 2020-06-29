//
//  RootDependencies.swift
//  HHModule
//
//  Created by Howie on 26/6/20.
//  Copyright © 2020 Beijing Bitstar Technology Co., Ltd. All rights reserved.
//

import Foundation

protocol RootDependencies {
    func vc1() -> VC1
    func vc2() -> VC2
    func service1() -> Service1
    func service2() -> IService2
    func service21() -> Service21
}
