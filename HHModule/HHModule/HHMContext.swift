//
//  HHMContext.swift
//  HHModule
//
//  Created by Howie on 26/6/20.
//  Copyright © 2020 Beijing Bitstar Technology Co., Ltd. All rights reserved.
//

import UIKit

protocol Builder {
    associatedtype TargetType
    func build() -> TargetType
}

protocol ServiceLocator {
    func service(_ cls: AnyClass) -> Any?
    func service(_ protocol: Protocol) -> Any?
    func builder<B, T>(_ protocol: B) -> T where B: Builder, B.TargetType == T
}

class Context: NSObject {
    fileprivate var parent: Context?
    
    init(_ parent: Context?) {
        self.parent = parent
    }
    
    override convenience init() {
        self.init(nil)
    }
}
