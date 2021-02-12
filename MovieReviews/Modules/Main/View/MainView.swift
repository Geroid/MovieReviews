//
//  MainView.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import RxSwift
import UIKit

final class MainView: UIView {

    // MARK: - Private properties

    private let disposeBag = DisposeBag()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

//    func bind(to viewModel: MainViewModelBindable) {
//        // Bindings UI controls to view model's input/output
//    }
}
