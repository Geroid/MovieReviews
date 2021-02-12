//
//  ApplicationCoordinator.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05.02.2021.
//  Copyright © 2021 Viktor Rezvantsev. All rights reserved.
//

import Foundation
import Swinject

fileprivate enum ApplicationAssembly {
    
    static var assemlies: [Assembly] = {
        return [
            CriticListCoordinatorAssembly()
        ]
    }()
}

class ApplicationCoordinator: BaseCoordinator<Void> {
    
    override init() {
        super.init()
        
        assembler = Assembler(assemblies())
    }
    
    override func assemblies() -> [Assembly] {
        return ApplicationAssembly.assemlies
    }
    
    override func start() {
        let coordinator = MainCoordinator()
        
        coordinate(to: coordinator)
    }
}
