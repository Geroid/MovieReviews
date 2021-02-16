//
//  ReviewsViewModel.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

/// Describes view model's input streams/single methods
protocol ReviewsViewModelInput {
    func startup()
}

/// Describes view model's output streams needed to update UI
protocol ReviewsViewModelOutput {
    var reviews: PublishRelay<[Review]> { get }
}

protocol ReviewsViewModelBindable: ReviewsViewModelInput & ReviewsViewModelOutput {}

final class ReviewsViewModel {
    private var service: NYTimesAPI
    private let disposeBag = DisposeBag()
    
    var reviewsRelay = PublishRelay<[Review]>()
    
    init(service: NYTimesAPI = NYTimesAPI()){
        self.service = service
    }
}

// MARK: - ReviewsViewModelBindable implementation

extension ReviewsViewModel: ReviewsViewModelBindable {
    var reviews: PublishRelay<[Review]> {
        return reviewsRelay
    }
    
	// Describe all bindings here
    func startup() {
        service.getReviews(offset: 15) { result in
            switch result {
            case .success(let reviews):
                self.reviewsRelay.accept(reviews)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - ReviewsModuleInput implementation

extension ReviewsViewModel: ReviewsModuleInput {}

// MARK: - ReviewsModuleOutput implementation

extension ReviewsViewModel: ReviewsModuleOutput {}
