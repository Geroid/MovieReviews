//
//  ReviewsView.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ReviewsView: UIView {

    // MARK: - Private properties
    private let padding: CGFloat = 8
    private let tableView: UITableView
    private let disposeBag = DisposeBag()

    // MARK: - Initializers

    init() {
        tableView = UITableView.init(frame: .zero, style: .grouped)
        super.init(frame: .zero)
        backgroundColor = .secondarySystemBackground
        setupTableView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func bind(to viewModel: ReviewsViewModelBindable) {
//         Bindings UI controls to view model's input/output
        viewModel.reviews
            .bind(to: tableView.rx.items) { tableView, index, review in
            let indexPath = IndexPath(item: index, section: 0)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as? ReviewTableViewCell else {
                fatalError("Unable to dequeue cell with identifier \(ReviewTableViewCell.identifier)")
            }
            cell.configureCell(with: review)
            return cell
        }.disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.identifier)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

    }
}
