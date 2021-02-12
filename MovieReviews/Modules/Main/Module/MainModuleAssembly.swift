//
//  MainModuleAssembly.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import Swinject

final class MainModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NYTimesAPI.self) { resolver in
            return NYTimesAPI()
        }
        
        container.register(MainViewModel.self) { resolver in
            let nyTimes = resolver.resolve(NYTimesAPI.self)!
            
            return MainViewModel(nyTimesAPI: nyTimes)
        }

        container.register(MainModule.self) { resolver in
            let viewModel = resolver.resolve(MainViewModel.self)!
            let view = MainViewController()
            
            return MainModule(
                view: view,
                input: viewModel,
                output: viewModel
            )
        }
    }
}
