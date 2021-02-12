//
//  CriticListViewController.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class CriticListViewController: UIViewController {

    // MARK: - Private properties

    private let viewModel: CriticListViewModelBindable
    
    private var criticsPublishRelay = PublishRelay<[Critic]>()
    private let disposeBag = DisposeBag()
    private let service = NYTimesAPI()

    // MARK: - Initializers

    init(viewModel: CriticListViewModelBindable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = "Critics"
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    override func loadView() {
        super.loadView()

        let view = CriticListView()
        view.backgroundColor = .white
        view.bind(to: viewModel)

        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.startup()
    }
    
}
