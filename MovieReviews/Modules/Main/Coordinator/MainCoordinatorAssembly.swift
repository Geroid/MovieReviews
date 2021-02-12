//
//  MainCoordinatorAssembly.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import InoMvvmc
import Swinject

final class MainCoordinatorAssembly: Assembly {
	func assemble(container: Container) {
		container.register(MainCoordinator.self) { _ in
			// replace '_' with 'resolver' and inject other coordinators if necessary
			return MainCoordinator()
		}
	}
}
