//
//  CriticViewModel.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/// Describes view model's input streams/single methods
protocol CriticViewModelInput {
}

/// Describes view model's output streams needed to update UI
protocol CriticViewModelOutput {}

protocol CriticViewModelBindable: CriticViewModelInput & CriticViewModelOutput {}

final class CriticViewModel {
    
    private var critic: Critic?
    private let disposeBag = DisposeBag()
    
    init(critic: Critic) {
        self.critic = critic
    }
}

// MARK: - CriticViewModelBindable implementation

extension CriticViewModel: CriticViewModelBindable {
	// Describe all bindings here
}

// MARK: - CriticModuleInput implementation

extension CriticViewModel: CriticModuleInput {}

// MARK: - CriticModuleOutput implementation

extension CriticViewModel: CriticModuleOutput {}
