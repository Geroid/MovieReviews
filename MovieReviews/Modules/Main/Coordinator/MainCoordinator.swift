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
    
    private var mainViewController: MainViewController?
    private var reviewsViewController: ReviewsViewController?
    
    public var childViewControllers = [UIViewController]()
    
    override init(){
        self.navigationController = UINavigationController()
        
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
//        reviewsView.assemble(container: con)
        let reviewsView = resolver.resolve(ReviewsModule.self)
        childViewControllers.append(reviewsView!.view)
        reviewsViewController = reviewsView!.view as! ReviewsViewController
        
        let criticListModule = resolver.resolve(CriticListModule.self)
        childViewControllers.append(criticListModule!.view)
        
        let mainViewModel = MainViewModel()
        mainViewController = MainViewController(viewModel: mainViewModel,
                                                childControllers: childViewControllers)
//        initializeViewControllers()
        navigationController.setViewControllers([mainViewController!], animated: true)
        
        setInitializeView()
        window?.rootViewController = navigationController
    }
    

    private func setInitializeView() {
        reviewsViewController!.view.frame = mainViewController!.view.bounds
        reviewsViewController!.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainViewController!.view.addSubview(reviewsViewController!.view)
        reviewsViewController!.didMove(toParent: mainViewController)
    }
    
}
