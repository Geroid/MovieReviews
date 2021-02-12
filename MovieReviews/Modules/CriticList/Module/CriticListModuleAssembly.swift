//
//  CriticListModuleAssembly.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import Swinject

final class CriticListModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NYTimesAPI.self) { resolver in
            return NYTimesAPI()
        }
        
        container.register(CriticListViewModel.self) { resolver in
            let nyTimes = resolver.resolve(NYTimesAPI.self)!
            
            return CriticListViewModel(service: nyTimes)
        }

        container.register(CriticListModule.self) { resolver in
            let viewModel = resolver.resolve(CriticListViewModel.self)!
            let view = CriticListViewController(viewModel: viewModel)
            
            return CriticListModule(
                view: view,
                input: viewModel,
                output: viewModel
            )
        }
    }
}
