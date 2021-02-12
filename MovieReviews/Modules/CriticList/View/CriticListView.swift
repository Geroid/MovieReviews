//
//  CriticListView.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class CriticListView: UIView {
  

    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    private var myCollectionView: UICollectionView?

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        setupCollectionView()
        setupCollectionConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func bind(to viewModel: CriticListViewModelBindable) {
        // Bindings UI controls to view model's input/output
        viewModel.critics
            .bind(to: myCollectionView!.rx.items(cellIdentifier: CriticViewCell.identifier, cellType: CriticViewCell.self)) {
                _, critic, cell in
                cell.configureCell(with: critic)
            }.disposed(by: disposeBag)
        
        myCollectionView!
            .rx
            .modelSelected(Critic.self)
            .bind(onNext: { critic in
                debugPrint(critic)
            }).disposed(by: disposeBag)
    }
    
    private func setupCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        layout.itemSize = CGSize(width: 170, height: 170)
        
        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myCollectionView?.showsVerticalScrollIndicator = false
        myCollectionView?.backgroundColor = .secondarySystemBackground
        myCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        

        guard let collectionView = myCollectionView else {
            return
        }
        collectionView.register(CriticViewCell.self, forCellWithReuseIdentifier: CriticViewCell.identifier)
        collectionView.frame = bounds
        addSubview(collectionView)

    }
    
    private func setupCollectionConstraints() {
        NSLayoutConstraint.activate([
            myCollectionView!.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            myCollectionView!.bottomAnchor.constraint(equalTo: bottomAnchor),
            myCollectionView!.leftAnchor.constraint(equalTo: leftAnchor),
            myCollectionView!.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
