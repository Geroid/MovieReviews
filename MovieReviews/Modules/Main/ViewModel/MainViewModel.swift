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
    var segmentedControlTap: Binder<Int> { get }
}

protocol MainViewModelOutput {
}

protocol MainViewModelBindable: MainViewModelInput & MainViewModelOutput {}

class MainViewModel {

    private let segmentedValueRelay = BehaviorRelay<Int>(value: 0)
    private let disposeBag = DisposeBag()
    
    init() {

    }
}

extension MainViewModel: MainModuleInput {}

extension MainViewModel: MainModuleOutput {}

// MARK: - MainViewModelBindable implementation
extension MainViewModel: MainViewModelBindable {
    
    // MARK: MainViewModelInput implementation
    func startup() {

    }
    
    var segmentedControlTap: Binder<Int> {
        return Binder(self.segmentedValueRelay) { $0.accept($1) }
    }
    
    // MARK: MainViewModelOutput implementation
}

