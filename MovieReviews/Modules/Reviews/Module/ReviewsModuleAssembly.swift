//
//  ReviewsModuleAssembly.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import Swinject

final class ReviewsModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NYTimesAPI.self) { _ in
            return NYTimesAPI()
        }
        container.register(ReviewsViewModel.self) { resolver in
            let service = resolver.resolve(NYTimesAPI.self)!
            
            return ReviewsViewModel(service: service)
        }
        
        container.register(ReviewsViewController.self) { resolver in
            let viewModel = resolver.resolve(ReviewsViewModel.self)!
            
            return ReviewsViewController(viewModel: viewModel)
        }

        container.register(ReviewsModule.self) { resolver in
            let viewModel = resolver.resolve(ReviewsViewModel.self)!
            let view = ReviewsViewController(viewModel: viewModel)
            
            return ReviewsModule(
                view: view,
                input: viewModel,
                output: viewModel
            )
        }
    }
}
