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
    
    private var childViewControllers = [UIViewController]()
    
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
        let window = UIApplication.shared.windows.filter {
            $0.isKeyWindow
        }.first
        let mainViewModel = MainViewModel()
        let mainController = MainViewController(viewModel: mainViewModel)
        let reviewsViewModel = ReviewsViewModel()
        let reviewsVC = ReviewsViewController(viewModel: reviewsViewModel)
        reviewsVC.view.frame = mainController.view.bounds
        reviewsVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        reviewsVC.didMove(toParent: mainController)
        navigationController.setViewControllers([mainController], animated: true)
        mainController.addChild(reviewsVC)
        mainController.view.addSubview(reviewsVC.view)
        
        //            let startIndex = mainViewModel.segmentedControlTap { }
        //            mainController.addChild(reviewsVC)
        //            mainController.view.addSubview(reviewsVC.view)
        
        window?.rootViewController = navigationController
    }
    
    private func initializeViewControllers() {
        
    }
    
    private func showReviews() {
        let reviewsViewModel = ReviewsViewModel()
        let reviewsVC = ReviewsViewController(viewModel: reviewsViewModel)
        childViewControllers.append(reviewsVC)
        //        reviewsVC.view.frame = mainController.view.bounds
        //        reviewsVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //        reviewsVC.didMove(toParent: mainController)
    }
    
    private func showCritics() {
        let criticListViewModel = CriticListViewModel()
        let criticListVC = CriticListViewController(viewModel: criticListViewModel)
        childViewControllers.append(criticListVC)
    }
}
