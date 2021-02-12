//
//  CriticCoordinatorAssembly.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import InoMvvmc
import Swinject

final class CriticCoordinatorAssembly: Assembly {
	func assemble(container: Container) {
		container.register(CriticCoordinator.self) { _ in
			// replace '_' with 'resolver' and inject other coordinators if necessary
			return CriticCoordinator()
		}
	}
}
