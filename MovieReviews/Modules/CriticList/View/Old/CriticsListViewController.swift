//
//  CriticsListViewController.swift
//  MovieReviews
//
//  Created by Viktor Rezvantsev on 27.07.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CriticsListViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!


    // MARK: - Properties

    private let interitemSpacing: CGFloat = 10
    private let itemsPerRow: Int = 2
    private let cellReuseIdentifier = String(describing: CriticCollectionViewCell.self)
    let searchController = UISearchController(searchResultsController: nil)

    var critics: [Critic] = []
    private var criticsPublishRelay = PublishRelay<[Critic]>()
    private let disposeBag = DisposeBag()
    let nyTimes = NYTimesAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadCritics()
        fetchCollectionView()
    }
    
    func setupCollectionView() {
        let cellNib = UINib(nibName: cellReuseIdentifier, bundle: nil)
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self,
                                                 action: #selector(didPullToRefresh),
                                                 for: .valueChanged)
        collectionView.register(cellNib, forCellWithReuseIdentifier: cellReuseIdentifier)
    }
    
    func loadCritics() {
        nyTimes.getCritics { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let critics):
                self.criticsPublishRelay.accept(critics)
//                for i in critics {
//                    self.critics.append(i)
//                }
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
    
    func fetchCollectionView() {
        criticsPublishRelay.bind(to: collectionView
                                    .rx
                                    .items(cellIdentifier: cellReuseIdentifier,
                                           cellType: CriticCollectionViewCell.self)) {
            collectionView, critic, cell in
            cell.configure(with: critic)
            cell.sizeToFit()
        }.disposed(by: disposeBag)
    }
    
    func configureCollectionView() {
//        collectionView
    }
}

//extension CriticsListViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return critics.count
//    }
//
//    func collectionView( _ collectionView: UICollectionView,
//                         cellForItemAt indexPath: IndexPath
//    ) -> UICollectionViewCell {
//        guard
//            let cell = collectionView.dequeueReusableCell(
//                withReuseIdentifier: cellReuseIdentifier,
//                for: indexPath) as? CriticCollectionViewCell
//            else {
//                fatalError("Unable to dequeue cell with identifier \(cellReuseIdentifier)")
//        }
//
//        let critic = critics[indexPath.row]
//        cell.configure(with: critic)
//
//        return cell
//    }
//}

extension CriticsListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let paddingSpace = interitemSpacing * CGFloat(itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)
        
        return CGSize(width: widthPerItem, height: 180)
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
    
//    private func callCriticListVC() -> CriticListViewController {
//        let vc = CriticListViewController(viewModel: )
//        return vc
//    }
    
    private func criticController() -> CriticsViewController {
        let identifier = "CriticsViewController"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? CriticsViewController else {
            fatalError("Unable to instantiate ViewController with identifier: \(identifier)")
        }
        
        return controller
    }
}
