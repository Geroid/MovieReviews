//
//  ViewController.swift
//  MovieReviews
//
//  Created by Viktor Rezvantsev on 24.07.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!

    let searchController = UISearchController(searchResultsController: nil)

    // MARK: - Properties
    
    private let cellReuseIdentifier = String(describing: ReviewTableViewCell.self)
    private let interitemSpasing: CGFloat = 10
    private let criticsListViewController = CriticsListViewController()

    private var reviews: [Review] = []
    private var currentOffset =  0
    private var service = MovieService()

    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: cellReuseIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        loadReviews(offset: currentOffset)
        searchController.searchBar.delegate = self
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self,
                                            action: #selector(didPullToRefresh),
                                            for: .valueChanged)
    }

    @IBAction func indexChanged(_ sender: UISegmentedControl) {
           switch segmentedControl.selectedSegmentIndex {
           case 0:
            headerLabel.text = segmentedControl.titleForSegment(at: 0)
           case 1:
            headerLabel.text = segmentedControl.titleForSegment(at: 1)
           default:
              break
           }
    }

    @objc private func didPullToRefresh() {
        loadReviews(offset: currentOffset)
    }


    func loadReviews(offset: Int) {
        service.getReviews(offset: offset){ [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let reviews):
                for i in reviews {
                    self.reviews.append(i)
                }
                DispatchQueue.main.async {
                    self.tableView.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func changeController() {
//        var vc: UIViewController?
    }

    func loadSearchResults(query: String) {
        reviews.removeAll()
        service.searchReviews(query: query) {[weak self] result in
            guard let self = self else { return }
            print(self.reviews)
            switch result {
            case .success(let reviews):
                for i in reviews {
                    self.reviews.append(i)
                }
                    self.tableView.reloadData()

            case .failure(let error):
                print(error.localizedDescription)
            }

        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

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

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadSearchResults(query: searchText)
    }
}

