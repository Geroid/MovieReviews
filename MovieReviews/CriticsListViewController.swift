//
//  CriticsListViewController.swift
//  MovieReviews
//
//  Created by Viktor Rezvantsev on 27.07.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import UIKit

class CriticsListViewController: UIViewController {
    
    private let interitemSpacing: CGFloat = 10
    private let itemsPerRow: Int = 2
    private let cellReuseIdentifier = String(describing: CriticCollectionViewCell.self)
    let searchController = UISearchController(searchResultsController: nil)

    @IBOutlet var collectionView: UICollectionView!

    @IBOutlet var searchBar: UISearchBar!


    var critics: [Critic] = []
    let service = MovieService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: cellReuseIdentifier, bundle: nil)
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self,
                                                 action: #selector(didPullToRefresh),
                                                 for: .valueChanged)
        collectionView.register(cellNib, forCellWithReuseIdentifier: cellReuseIdentifier)
        loadCritics()
    }
    
    func loadCritics() {
        service.getCritics { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let critics):
                for i in critics {
                    self.critics.append(i)
                }
                DispatchQueue.main.async {
                    self.collectionView.refreshControl?.endRefreshing()
                    self.collectionView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func didPullToRefresh() {
        critics.removeAll()
        loadCritics()
    }
}

extension CriticsListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return critics.count
    }
    
    func collectionView( _ collectionView: UICollectionView,
                         cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: cellReuseIdentifier,
                for: indexPath) as? CriticCollectionViewCell
            else {
                fatalError("Unable to dequeue cell with identifier \(cellReuseIdentifier)")
        }
        
        let critic = critics[indexPath.row]
        cell.configure(with: critic)
        
        return cell
    }
}

extension CriticsListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let paddingSpace = interitemSpacing * CGFloat(itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)
        
        return CGSize(width: widthPerItem, height: 200)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return interitemSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: interitemSpacing,
            left: interitemSpacing,
            bottom: interitemSpacing,
            right: interitemSpacing
        )
    }
}

extension CriticsListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = criticController()
        controller.critic = critics[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func criticController() -> CriticsViewController {
        let identifier = "CriticsViewController"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? CriticsViewController else {
            fatalError("Unable to instantiate ViewController with identifier: \(identifier)")
        }
        
        return controller
    }
}
