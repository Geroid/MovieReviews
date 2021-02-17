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

    private var critic: Critic?
    private var navigationController: UINavigationController?
    
    
	override func assemblies() -> [Assembly] {
		return [
			CriticListModuleAssembly()
		]
	}
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

	override func start() {
		// Implement actual start from window/nav controller/tab bar controller here
        
        let window = UIApplication.shared.windows.filter {
            $0.isKeyWindow
        }.first
        let viewModel = CriticListViewModel()
        let criticListVC = CriticListViewController(viewModel: viewModel)
        window?.rootViewController = criticListVC
	}
    
    func showCriticScreen(critic: Critic) {
        let viewModel = CriticViewModel(critic: critic)
        let criticViewController = CriticViewController(viewModel: viewModel)
        navigationController?.show(criticViewController, sender: self)
//        navigationController?.pushViewController(criticViewController, animated: true)
        debugPrint("Nav controller - \(String(describing: navigationController))")
    }
}
