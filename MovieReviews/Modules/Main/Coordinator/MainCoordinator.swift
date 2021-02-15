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
    let criticListViewModel = CriticListViewModel()
    let reviewsViewModel = ReviewsViewModel()
    
	override func assemblies() -> [Assembly] {
		return [
			MainModuleAssembly(),
            ReviewsModuleAssembly(),
            CriticListModuleAssembly()
		]
	}

	override func start() {
		// Implement actual start from window/nav controller/tab bar controller here
        if let window = UIApplication.shared.keyWindow {
            let mainController = MainViewController()
            let reviewsVC = ReviewsViewController(viewModel: reviewsViewModel)
            let criticListVC = CriticListViewController(viewModel: criticListViewModel)
            let navigationController = UINavigationController()
            navigationController.setViewControllers([mainController,criticListVC, reviewsVC], animated: true)
//            mainController.addChild(criticListVC)
//            mainController.view.addSubview(criticListVC.view)
            window.rootViewController = navigationController
        }
	}
}
