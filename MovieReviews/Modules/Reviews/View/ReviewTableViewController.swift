//
//  ReviewTableViewController.swift
//  MovieReviews
//
//  Created by Viktor Rezvantsev on 02.08.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ReviewTableViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var reviewsTable: UITableView!
    
    // MARK: - Properties
    
    private let cellReuseIdentifier = String(describing: ReviewTableViewCell.self)
    private let interitemSpasing: CGFloat = 10
    
    private var reviewsPublishRelay = PublishRelay<[Review]>()
    private let disposeBag = DisposeBag()
    private var reviews: [Review] = []
    private var currentOffset =  0
    private var service = NYTimesAPI()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
//        setupCellConfig()
//        setupTableView()
        reviewsTable.dataSource = self
        reviewsTable.delegate = self
        loadReviews(offset: currentOffset)
        searchController.searchBar.delegate = self
    }

    func configureTable() {
        let cellNib = UINib(nibName: cellReuseIdentifier, bundle: nil)
        reviewsTable.register(cellNib, forCellReuseIdentifier: cellReuseIdentifier)
        
        reviewsTable.refreshControl = UIRefreshControl()
        reviewsTable.refreshControl?.addTarget(self,
                                               action: #selector(didPullToRefresh),
                                               for: .valueChanged)
    }
    
    @objc private func didPullToRefresh() {
//        reviewsPublishRelay.accept([])
        reviews.removeAll()
        currentOffset = 0
        loadReviews(offset: currentOffset)
    }
    
    func loadReviews(offset: Int) {
        service.getReviews(offset: offset){ [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let reviews):
//                self.reviewsPublishRelay.accept(reviews)
                for i in reviews {
                    self.reviews.append(i)
                }
                DispatchQueue.main.async {
                    self.reviewsTable.refreshControl?.endRefreshing()
                    self.reviewsTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadSearchResults(query: String) {
//        reviewsPublishRelay.accept([])
        reviews.removeAll()
        self.reviewsTable.reloadData()
        service.searchReviews(query: query) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let reviews):
//                self.reviewsPublishRelay.accept(reviews)
                for i in reviews {
                    self.reviews.append(i)
                }
                self.reviewsTable.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setupTableView() {
        reviewsPublishRelay.bind(to: reviewsTable.rx.items) { tableView, index, element in
            let indexPath = IndexPath(item: index, section: 0)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) as? ReviewTableViewCell else {
                fatalError("Unable to dequeue cell with identifier \(self.cellReuseIdentifier)")
            }
            cell.configure(with: element)
            return cell
        }.disposed(by: disposeBag)
    }
    
    func setupCellConfig() {
        reviewsPublishRelay.bind(to: reviewsTable
                                    .rx
                                    .items(cellIdentifier: self.cellReuseIdentifier,
                                           cellType: ReviewTableViewCell.self)) {
                    row, review, cell in
            cell.configure(with: review)
        }
        .disposed(by: disposeBag)
    }
}

extension ReviewTableViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? ReviewTableViewCell else {
            fatalError("Unable to dequeue cell with identifier \(cellReuseIdentifier)")
        }
        let review = reviews[indexPath.row]
        cell.configure(with: review)


        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == reviews.count - 1 {
            currentOffset += 20
            loadReviews(offset: currentOffset)
        }
    }
}

extension ReviewTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadSearchResults(query: searchText)
    }
}
