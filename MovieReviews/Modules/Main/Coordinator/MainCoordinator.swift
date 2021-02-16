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
    
    private var navigationController: UINavigationController
    
    private var childCoordinators = [BaseCoordinator<Void>]()
    
    init(with navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
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
            let mainViewModel = MainViewModel()
            let mainController = MainViewController(viewModel: mainViewModel)
            navigationController.setViewControllers([mainController], animated: true)
//            let criticListViewModel = CriticListViewModel()
//            let criticListVC = CriticListViewController(viewModel: criticListViewModel)
            let reviewsViewModel = ReviewsViewModel()
            let reviewsVC = ReviewsViewController(viewModel: reviewsViewModel)
//            let startIndex = mainViewModel.segmentedControlTap { }
            mainController.addChild(reviewsVC)
            mainController.view.addSubview(reviewsVC.view)
            reviewsVC.view.frame = mainController.view.bounds
            reviewsVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            window.rootViewController = navigationController
        }
	}
    
    private func showReviews() {
        let reviewsCoordinator = ReviewsCoordinator()
        reviewsCoordinator.start()
        childCoordinators.append(reviewsCoordinator)
    }
    
    private func showCritics() {
        let criticsCoordinator = CriticListCoordinator(with: navigationController)
        criticsCoordinator.start()
        childCoordinators.append(criticsCoordinator)
    }
}
