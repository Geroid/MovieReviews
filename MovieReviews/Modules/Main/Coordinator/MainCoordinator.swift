//
//  MainCoordinator.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import InoMvvmc
import Swinject
import UIKit

final class MainCoordinator: BaseCoordinator<Void> {
	// Replace <Void> with some other result type if necessary
    let viewModel = CriticListViewModel()
	override func assemblies() -> [Assembly] {
		return [
			MainModuleAssembly(),
            CriticModuleAssembly()
		]
	}

	override func start() {
		// Implement actual start from window/nav controller/tab bar controller here
        if let window = UIApplication.shared.keyWindow {
//            let reviewsModule = resolver.resolve(ReviewsModule.self)
            let criticListVC = CriticListViewController(viewModel: viewModel)
//            let criticListModule = resolver.resolve(CriticListModule.self)!
            
            let controller = UINavigationController(nibName: nil, bundle: nil)
            controller.setViewControllers([criticListVC], animated: true)
//            controller.setViewControllers([criticListModule.view], animated: true)
//            reviewsModule.view,
            window.rootViewController = controller
        }
	}
}
