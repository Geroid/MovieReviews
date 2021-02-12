//
//  ReviewsViewModel.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import Foundation
import RxSwift

/// Describes view model's input streams/single methods
protocol ReviewsViewModelInput {}

/// Describes view model's output streams needed to update UI
protocol ReviewsViewModelOutput {}

protocol ReviewsViewModelBindable: ReviewsViewModelInput & ReviewsViewModelOutput {}

final class ReviewsViewModel {
    private let disposeBag = DisposeBag()
}

// MARK: - ReviewsViewModelBindable implementation

extension ReviewsViewModel: ReviewsViewModelBindable {
	// Describe all bindings here
}

// MARK: - ReviewsModuleInput implementation

extension ReviewsViewModel: ReviewsModuleInput {}

// MARK: - ReviewsModuleOutput implementation

extension ReviewsViewModel: ReviewsModuleOutput {}
