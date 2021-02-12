//
//  CriticCoordinator.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import InoMvvmc
import Swinject

final class CriticCoordinator: BaseCoordinator<Void> {
	// Replace <Void> with some other result type if necessary

	override func assemblies() -> [Assembly] {
		return [
			CriticModuleAssembly()
		]
	}

	override func start() {
		// Implement actual start from window/nav controller/tab bar controller here
	}
}