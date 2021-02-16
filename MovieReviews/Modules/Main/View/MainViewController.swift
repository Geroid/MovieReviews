//
//  MainViewController.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: - Private properties

    private let viewModel: MainViewModelBindable

    // MARK: - Initializers

    init(viewModel: MainViewModelBindable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    override func loadView() {
        super.loadView()

        let view = MainView()
        view.bind(to: viewModel)
        navigationItem.titleView = view.segmentedControl!
        self.navigationController?.navigationBar.barTintColor = Colors.orange
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
