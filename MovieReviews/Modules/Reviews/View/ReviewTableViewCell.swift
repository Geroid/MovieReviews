//
//  ReviewTableViewCell.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 15.02.2021.
//  Copyright © 2021 Viktor Rezvantsev. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    static let identifier = "reviewTableViewCell"

    private let padding: CGFloat = 8
    private let cornerRadius: CGFloat = 5
    
    private lazy var reviewImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode  = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "photo")
        imageView.layer.cornerRadius = cornerRadius
        imageView.frame = CGRect(x: 0, y: 0, width: 130, height: 160)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private lazy var linkButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
      //add code here to add views to hierarchy
        backgroundColor = .white
        addSubviews(reviewImage,
                    titleLabel,
                    detailLabel,
                    authorLabel,
                    dateLabel,
                    linkButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            reviewImage.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            reviewImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            reviewImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: padding),
            reviewImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: padding)
        ])
    }
}
