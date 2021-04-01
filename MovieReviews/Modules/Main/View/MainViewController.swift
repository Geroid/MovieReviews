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
    private var segmentedControl: UISegmentedControl?
    private var childControllers: [UIViewController]

    // MARK: - Initializers

    init(viewModel: MainViewModelBindable, childControllers: [UIViewController]) {
        self.viewModel = viewModel
        self.childControllers = childControllers
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
        segmentedControl = view.segmentedControl
        segmentedControl?.addTarget(self, action: #selector(changeIndex(_:)), for: .valueChanged)
        self.navigationController?.navigationBar.barTintColor = Colors.orange
        self.view = view
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Private methods
    
    @objc private func changeIndex(_ sender: UISegmentedControl) {
        switch segmentedControl?.selectedSegmentIndex {
        case 0:
            segmentedControl!.backgroundColor = Colors.orange
            configureReviewsController()
            childControllers[1].remove()
        case 1:
            segmentedControl!.backgroundColor = Colors.blue
            configureCriticListController()
            childControllers[0].remove()
        default:
            break
        }
    }

    private func configureReviewsController() {
        let reviewsVC = childControllers[0]
        addChild(reviewsVC)
        reviewsVC.view.frame = view.bounds
        reviewsVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(reviewsVC.view)
        reviewsVC.didMove(toParent: nil)
    }
    
    private func configureCriticListController() {
        let criticListVC = childControllers[1]
        addChild(criticListVC)
        criticListVC.view.frame = view.bounds
        criticListVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addChild(criticListVC)
        view.addSubview(criticListVC.view)
        criticListVC.didMove(toParent: nil)
    }
}
