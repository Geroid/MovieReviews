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
			MainModuleAssembly()
		]
	}

	override func start() {
		// Implement actual start from window/nav controller/tab bar controller here
        if let window = UIApplication.shared.keyWindow {
            let mainController = MainViewController()
            let criticListVC = CriticListViewController(viewModel: viewModel)
            
            window.rootViewController = criticListVC
        }
	}
}
