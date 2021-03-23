//
//  Dependencies.swift
//  DebugApp
//
//  Created by Yugo Sugiyama on 2021/03/23.
//

import Foundation
import SwiftUI

//Ref: https://basememara.com/swift-dependency-injection-via-property-wrapper/
/// A dependency collection that provides resolutions for object instances.
public class Dependencies {
    /// Stored object instance factories.
    private var modules: [String: Module] = [:]

    private init() {}
    deinit { modules.removeAll() }
}

extension Dependencies {
    /// Registers a specific type and its instantiating factory.
    public func add(module: Module) {
        modules[module.name] = module
    }
}

private extension Dependencies {
    /// Resolves through inference and returns an instance of the given type from the current default container.
    ///
    /// If the dependency is not found, an exception will occur.
    func resolve<T>(for name: String? = nil) -> T {
        let name = name ?? String(describing: T.self)

        guard let component: T = modules[name]?.dependency as? T else {
            fatalError("Dependency '\(T.self)' not resolved!")
        }

        return component
    }
}

// MARK: - Public API
public extension Dependencies {
    /// Composition root container of dependencies.
    static var root = Dependencies()

    /// Construct dependency resolutions.
    convenience init(@ModuleBuilder _ modules: () -> [Module]) {
        self.init()
        modules().forEach { add(module: $0) }
    }

    /// Construct dependency resolution.
    convenience init(@ModuleBuilder _ module: () -> Module) {
        self.init()
        add(module: module())
    }

    /// Assigns the current container to the composition root.
    func build() {
        // Used later in property wrapper
        Self.root = self
    }

    /// DSL for declaring modules within the container dependency initializer.
    @_functionBuilder struct ModuleBuilder {
        public static func buildBlock(_ modules: Module...) -> [Module] { modules }
        public static func buildBlock(_ module: Module) -> Module { module }
    }
}

/// A type that contributes to the object graph.
public struct Module {
    fileprivate let name: String
    fileprivate let dependency: Any

    public init<T>(_ name: String? = nil, _ resolve: @escaping () -> T) {
        self.name = name ?? String(describing: T.self)
        self.dependency = resolve()
    }
}

// MARK: Inject
@propertyWrapper
public struct Inject<Value> {

    private let name: String?
    @State private var storage: Value?

    public var wrappedValue: Value {
        Dependencies.root.resolve(for: name)
    }

    public init(_ name: String? = nil) {
        self.name = name
    }
}


