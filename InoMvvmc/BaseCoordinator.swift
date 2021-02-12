//
//  BaseCoordinator.swift
//  InoMvvmc
//
//  Created by Yaroslav Magin on 03.01.2021.
//

import Foundation
import RxSwift
import Swinject

/// Basic coordinator for modules. Supports Swinject.
open class BaseCoordinator<ResultType> {
    
    // MARK: Swinject
    
    public var assembler: Assembler!
    public var resolver: Resolver {
        return assembler.resolver
    }
    
    // MARK: Lifecycle
    
    private let resultSubject = PublishSubject<ResultType>()
    
    /// Subscribe to this trait to perform some job on closing coordinator.
    public var onComplete: Single<ResultType> {
        return resultSubject.asSingle()
    }
    
    private let uuid = UUID()
    private var childCoordinators: [UUID: AnyObject] = [:]
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Public methods
    
    /// Overridable method specifying module assemblies for coordinator (could contain more than one module)
    open func assemblies() -> [Assembly] {
        return []
    }
    
    /// Overridable method which must be implemented to start coordinator from some view controller.
    open func start() {
        fatalError("Should be implemented in child classes!")
    }
    
    /// Performs transition to other coordinator.
    public func coordinate<T>(to other: BaseCoordinator<T>) {
        // dependencies init
        let childAssembler = Assembler(parentAssembler: assembler)
        childAssembler.apply(assemblies: other.assemblies())
        other.assembler = childAssembler
        
        // maintain coordinator lifecycle
        store(childCoordinator: other)
        _ = other.onComplete.do(onDispose: { [weak self] in
            self?.free(childCoordinator: other)
        })
        
        other.start()
    }
    
    /// Completes coordinator's work with some result.
    /// IMPORTANT: always call this method when job is done, it's necessary to release coordinator and avoid memory leaks.
    public func complete(with result: ResultType) {
        resultSubject.onNext(result)
    }
    
    // MARK: - Private methods
    
    private func store<T>(childCoordinator: BaseCoordinator<T>) {
        childCoordinators[childCoordinator.uuid] = childCoordinator
    }
    
    private func free<T>(childCoordinator: BaseCoordinator<T>) {
        childCoordinators.removeValue(forKey: childCoordinator.uuid)
    }
}
