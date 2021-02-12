//
//  CriticModuleAssembly.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import Swinject

final class CriticModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CriticViewModel.self) { _ in
            // replace '_' with 'resolver' and inject dependencies if necessary
            return CriticViewModel()
        }

        container.register(CriticModule.self) { resolver in
            let viewModel = resolver.resolve(CriticViewModel.self)!
            let view = CriticViewController(viewModel: viewModel)
            
            return CriticModule(
                view: view,
                input: viewModel,
                output: viewModel
            )
        }
    }
}
