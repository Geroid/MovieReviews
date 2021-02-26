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
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 5
        stack.distribution = .equalSpacing
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
        imageView.frame.size.width = 120
        imageView.frame.size.height = 150
        imageView.clipsToBounds = true
//        imageView.frame = CGRect(x: 0, y: 0, width: 120, height: 150)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
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
        backgroundColor = .secondarySystemBackground
        self.selectionStyle = .none
        addSubview(cellView)
        cellView.addSubviews(stackView, reviewImage)
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            reviewImage.topAnchor.constraint(equalTo: cellView.topAnchor, constant: padding),
            reviewImage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: padding),
            reviewImage.widthAnchor.constraint(equalToConstant: 120),
            reviewImage.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -padding),
            
            stackView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: reviewImage.trailingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -padding)
            // bottom , trailing
        ])
    }
}

extension ReviewTableViewCell {
    public func configureCell(with model: Review) {
        titleLabel.text = "\(model.title)"
        detailLabel.text = "\(model.summaryShort ?? "")"
        authorLabel.text = "\(model.byline ?? "")"
        dateLabel.text = "\(DateHelper.dateFormatter.string(from: model.date))"
        setImage(pictureURL: model.pictureURL)
    }
    
    private func setImage(pictureURL: String) {
        DispatchQueue.global().async {
            if let url = URL(string: pictureURL) {
                let data = try! Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.reviewImage.image = UIImage(data: data)
                }
            }
        }
    }
}
