//
//  CriticView.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import RxSwift
import UIKit

final class CriticView: UIView {

    
    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode  = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "photo")
        imageView.layer.cornerRadius = 5
        imageView.frame = CGRect(x: 0, y: 0, width: 120, height: 140)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()


    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        backgroundColor = .white
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func bind(to viewModel: CriticViewModelBindable) {
        // Bindings UI controls to view model's input/output
    }
    
}
