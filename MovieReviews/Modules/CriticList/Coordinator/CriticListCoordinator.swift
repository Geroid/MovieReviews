//
//  CriticListCoordinator.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import InoMvvmc
import Swinject

final class CriticListCoordinator: BaseCoordinator<Void> {
	// Replace <Void> with some other result type if necessary

    private var navigationController: UINavigationController?
    private var critic: Critic?
    
	override func assemblies() -> [Assembly] {
		return [
			CriticListModuleAssembly()
		]
	}

	override func start() {
		// Implement actual start from window/nav controller/tab bar controller here
        if let window = UIApplication.shared.keyWindow {
//            let viewModel = CriticListViewModel()
//            let criticListVC = CriticListViewController(viewModel: viewModel)
            navigationController = UINavigationController(nibName: nil, bundle: nil)
            window.rootViewController = navigationController
        }
	}
    
    func showCriticScreen(critic: Critic) {
        let viewModel = CriticViewModel(critic: critic)
        let criticViewController = CriticViewController(viewModel: viewModel)
        navigationController?.pushViewController(criticViewController, animated: true)
    }
}
