//
//  MainViewModel.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05.02.2021.
//  Copyright © 2021 Viktor Rezvantsev. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol MainViewModelInput {
    func startup()
    var buttonTap: Binder<Void> { get }
}

protocol MainViewModelOutput {
    var initialText: Driver<String> { get }
}

protocol MainViewModelBindable: MainViewModelInput & MainViewModelOutput {}

class MainViewModel {
//    let startupService: IStartupService
    let nyTimesAPI: NYTimesAPI
    
    private let initialDataRelay = PublishRelay<String>()
    private let buttonRelay = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    
//    startupService: IStartupService
    init(nyTimesAPI: NYTimesAPI) {
//        self.startupService = startupService
        self.nyTimesAPI = nyTimesAPI
        
        buttonRelay.subscribe(onNext: { _ in
            print("Successful tap!")
        }).disposed(by: disposeBag)
    }
}

extension MainViewModel: MainModuleInput {}

extension MainViewModel: MainModuleOutput {}

// MARK: - MainViewModelBindable implementation
extension MainViewModel: MainViewModelBindable {
    // MARK: MainViewModelInput implementation
    func startup() {
//        initialDataRelay.accept(startupService.startup())
    }
    
    var buttonTap: Binder<Void> {
        return Binder(self.buttonRelay) { $0.accept($1) }
    }
    
    // MARK: MainViewModelOutput implementation
    var initialText: Driver<String> {
        return initialDataRelay.asDriver(onErrorJustReturn: "")
    }
}

