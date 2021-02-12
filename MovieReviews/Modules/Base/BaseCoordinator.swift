//
//  BaseCoordinator.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import Foundation
import RxSwift
import Swinject

class BaseCoordinator<ResultType> {
    
    // MARK: Swinject
    
    var assembler: Assembler!
    var resolver: Resolver {
        return assembler.resolver
    }
    
    // MARK: Lifecycle
    
    private let resultSubject = PublishSubject<ResultType>()
    var onComplete: Single<ResultType> {
        return resultSubject.asSingle()
    }
    
    private let uuid = UUID()
    private var childCoordinators: [UUID: AnyObject] = [:]
    
    // MARK: - Public methods
    
    func assemblies() -> [Assembly] {
        return []
    }
    
    func start() {
        fatalError("Should be implemented in child classes!")
    }
    
    func coordinate<T>(to other: BaseCoordinator<T>) {
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
    
    func complete(with result: ResultType) {
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
