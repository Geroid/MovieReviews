//
//  CriticListViewModel.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

/// Describes view model's input streams/single methods
protocol CriticListViewModelInput {
    func startup()
    
    var reload: Binder<Void> { get }
    
    func showCritic(critic: Critic)
    
    
//    var selectedCritic: PublishRelay<Critic> { get }
}

/// Describes view model's output streams needed to update UI
protocol CriticListViewModelOutput {
    var critics: PublishRelay<[Critic]> { get }
}

protocol CriticListViewModelBindable: CriticListViewModelInput & CriticListViewModelOutput {}

final class CriticListViewModel {
    
    private let service: NYTimesAPI
    private let coordinator: CriticListCoordinator?
    private let navigationController: UINavigationController = UINavigationController()
    
    var criticsRelay = PublishRelay<[Critic]>()
    
    // Buttons
    private let cellRelay = PublishRelay<Void>()
    private let reloadRelay = PublishRelay<Void>()
    
    private let disposeBag = DisposeBag()
    
    init(service: NYTimesAPI = NYTimesAPI()) {
        self.service = service
        self.coordinator = CriticListCoordinator(with: navigationController)
    }

}

// MARK: - CriticListViewModelBindable implementation

extension CriticListViewModel: CriticListViewModelBindable {
    var reload: Binder<Void> {
        return Binder(self.reloadRelay) { $0.accept($1) }
    }
    
    var critics: PublishRelay<[Critic]> {
        return criticsRelay
    }

    func showCritic(critic: Critic) {
        coordinator?.start()
        coordinator?.showCriticScreen(critic: critic)
    }
    
    func startup() {
        service.getCritics {
            [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let critics):
                    self.criticsRelay.accept(critics)
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
}

// MARK: - CriticListModuleInput implementation

extension CriticListViewModel: CriticListModuleInput {}

// MARK: - CriticListModuleOutput implementation

extension CriticListViewModel: CriticListModuleOutput {}
