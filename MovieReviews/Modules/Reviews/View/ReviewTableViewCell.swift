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

    private let padding: CGFloat = 10
    private let cornerRadius: CGFloat = 5
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        
        stack.distribution  = .fillEqually
        return stack
    }()
    
    private lazy var reviewImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode  = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "photo")
        imageView.layer.cornerRadius = cornerRadius
        imageView.frame = CGRect(x: 0, y: 0, width: 120, height: 160)
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
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
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
        addSubviews(stackView, reviewImage)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(titleLabel)
        stackView.addSubview(detailLabel)
        stackView.addSubview(authorLabel)
        stackView.addSubview(dateLabel)

    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            reviewImage.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            reviewImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            reviewImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            reviewImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            stackView.leftAnchor.constraint(equalTo: reviewImage.rightAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -padding)
        ])
    }
}

extension ReviewTableViewCell {
    public func configureCell(with model: Review) {
        titleLabel.text = "\(model.title)"
        detailLabel.text = "\(model.summaryShort ?? "")"
        authorLabel.text = "\(model.byline ?? "")"
        dateLabel.text = "\(model.date)"
        setImage(pictureURL: model.pictureURL)
    }
    
    private func setImage(pictureURL: String) {
        if let url = URL(string: pictureURL) {
            let data = try! Data(contentsOf: url)
            self.reviewImage.image = UIImage(data: data)
        } else {
            self.reviewImage.image = UIImage(named: "photo")
        }
    }
}
