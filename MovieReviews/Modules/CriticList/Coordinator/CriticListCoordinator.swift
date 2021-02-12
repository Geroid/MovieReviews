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
//    private let criticLisViewModel = CriticListViewModel(service: NYTimesAPI())
    
	override func assemblies() -> [Assembly] {
		return [
			CriticListModuleAssembly()
		]
	}

	override func start() {
		// Implement actual start from window/nav controller/tab bar controller here
//        let viewController = CriticListViewController(viewModel: criticLisViewModel)
        
//        navigati
	}
}
