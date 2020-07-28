//
//  ViewController.swift
//  MovieReviews
//
//  Created by Viktor Rezvantsev on 24.07.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    private let cellReuseIdentifier = String(describing: ReviewTableViewCell.self)
    private let interitemSpasing: CGFloat = 10
    private let criticsListViewController = CriticsListViewController()

    private var reviews: [Review] = []
    private var currentPage =  1
    private var service = MovieService()

    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: cellReuseIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.tableFooterView = UIView()
        loadReviews()
    }

    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        var vc: UIViewController?
           switch segmentedControl.selectedSegmentIndex {
           case 0:
               navigationItem.title = segmentedControl.titleForSegment(at: 0)
           case 1:
              vc = criticsListViewController
           default:
              break
           }
    }


    func loadReviews() {
        service.getReviews{ [weak self] result in
            guard let self = self else { return }

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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == reviews.count - 1 {
            currentPage += 1
//            loadReviews()
        }
    }
}

