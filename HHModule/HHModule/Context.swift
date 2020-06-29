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
    mutating func service<S>() -> S?
    mutating func builder<B: Builder>() -> B?
}

private func typeName(some: Any) -> String {
    return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
}

protocol ServiceRegistry {
    mutating func register<T>(instance: T)
    mutating func register<T>(recipe: @escaping () -> T)
    mutating func register<B: Builder>(builder: B)
}

final class Context {
    enum ServiceKind<T> {
        case Instance(T)
        case Recipe(() -> T)
        func unwrap() -> T {
            switch self {
            case let .Instance(instance):
                return instance
            case let .Recipe(recipe):
                return recipe()
            }
        }
    }

    fileprivate var parent: Context?
    fileprivate lazy var services = [String: ServiceKind<Any>]()
    fileprivate lazy var builders = [String: Any]()
    fileprivate lazy var prepares = [String: () -> ()]()

    lazy var cached: ContextCache = ContextCache(self)

    init(_ parent: Context? = nil) {
        self.parent = parent
    }
    
    func registry(_ prepare: @escaping () -> ()) -> ServiceRegistry {
        var prepared = false
        let p = {
            if prepared {
                return
            }
            prepare()
            prepared = true
        }
        return ContextRegister(self, p)
    }
}

extension Context : ServiceRegistry {
    func register<T>(instance: T) {
        let name = typeName(some: T.self)
        services[name] = .Instance(instance)
    }

    func register<T>(recipe: @escaping () -> T) {
        let name = typeName(some: T.self)
        services[name] = .Recipe(recipe)
    }

    func register<B: Builder>(builder: B) {
        let name = typeName(some: B.self)
        builders[name] = builder
    }
}

struct ContextRegister: ServiceRegistry {
    fileprivate let context: Context
    fileprivate var prepare: ()->()
    
    init(_ context: Context&ServiceRegistry, _ prepare: @escaping ()->()) {
        self.context = context
        self.prepare = prepare
    }
    
    func register<T>(instance: T) {
        let name = typeName(some: T.self)
        context.prepares[name] = prepare
        context.register(instance: instance)
    }
    
    func register<T>(recipe: @escaping () -> T) {
        let name = typeName(some: T.self)
        context.prepares[name] = prepare
        context.register(recipe: recipe)
    }
    
    func register<B: Builder>(builder: B) {
        let name = typeName(some: B.TargetType.self)
        context.prepares[name] = prepare
        context.register(builder: builder)
    }
}

extension Context: ServiceLocator {
    func service<S>() -> S? {
        let name = typeName(some: S.self)
        if let prepare = prepares[name] {
            prepare()
        }
        return services[name]?.unwrap() as? S ?? parent?.service()
    }

    func builder<B: Builder>() -> B? {
        let name = typeName(some: B.TargetType.self)
        if let prepare = prepares[name] {
            prepare()
        }
        return builders[name] as? B ?? parent?.builder()
    }
}

struct ContextCache {
    fileprivate weak var context: Context?
    fileprivate lazy var caches = [AnyHashable:Any]()

    init(_ context: Context) {
        self.context = context
    }
}

extension ContextCache: ServiceLocator {
    mutating func service<S>() -> S? {
        // TODO: Thread Safety
        let name = typeName(some: S.self)
        if let cache = caches[name] {
            return cache as? S
        }
        if let instance: S = context?.service() {
            caches[name] = instance
            return instance
        } else {
            return nil
        }
    }
    
    func builder<B : Builder>() -> B? {
        return context?.builder()
    }
}
