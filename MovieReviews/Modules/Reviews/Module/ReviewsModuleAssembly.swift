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
        container.register(ReviewsViewModel.self) { _ in
            // replace '_' with 'resolver' and inject dependencies if necessary
            return ReviewsViewModel()
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
