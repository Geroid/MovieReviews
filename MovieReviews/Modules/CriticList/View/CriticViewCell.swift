//
//  CriticCellView.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 08.02.2021.
//  Copyright © 2021 Viktor Rezvantsev. All rights reserved.
//

import UIKit

final class CriticViewCell: UICollectionViewCell {
    
    static let identifier = "CriticViewCell"

    private let padding: CGFloat = 8
    
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
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private override init(frame: CGRect) {
      super.init(frame: frame)
      setupViews()
      setupConstraints()
    }
    
    public convenience init(with model: Critic) {
      self.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
      //add code here to add views to hierarchy
        backgroundColor = .white
        addSubviews(imageView, textLabel)
    }
  
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(
              equalTo: self.topAnchor, constant: padding),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                               constant: padding + 20),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                constant: -padding - 20)
        ])
        
        NSLayoutConstraint.activate([
          // TopAnchor relative to the bottom of imageView
          textLabel.topAnchor.constraint(
            equalTo: imageView.bottomAnchor,
            constant: padding),
          // Set left, right, bottom sides
          textLabel.leadingAnchor.constraint(
            equalTo: imageView.leadingAnchor,
            constant: padding),
          textLabel.trailingAnchor.constraint(
            equalTo: self.trailingAnchor,
            constant: -padding),
          textLabel.bottomAnchor.constraint(
            equalTo: self.bottomAnchor,
            constant: -padding)
        ])
        
        textLabel.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        textLabel.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
        
    }
}


// MARK: - View Configuration
extension CriticViewCell {
    public func configureCell(with model: Critic) {
        textLabel.text = "\(model.name)"
        guard let pictureUrl = model.pictureURL else {
            return
        }
        setImage(pictureURL: pictureUrl)
    }
    
    private func setImage(pictureURL: String) {
        DispatchQueue.global().async {
            if let url = URL(string: pictureURL) {
                let data = try! Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            } else {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(named: "photo")
                }
            }
        }
        
    }
}
