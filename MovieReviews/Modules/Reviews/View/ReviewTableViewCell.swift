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
    
    let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 5
        stack.distribution = .fillProportionally
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(detailLabel)
        stack.addArrangedSubview(authorLabel)
        stack.addArrangedSubview(dateLabel)
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
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
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
        self.selectionStyle = .none
        addSubview(cellView)
        cellView.addSubviews(stackView, reviewImage)
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            reviewImage.topAnchor.constraint(equalTo: cellView.topAnchor),
            reviewImage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            reviewImage.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            reviewImage.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -padding),
            
            stackView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: padding),
            stackView.leftAnchor.constraint(equalTo: reviewImage.rightAnchor, constant: padding),
            stackView.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -padding)
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
