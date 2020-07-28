//
//  ReviewTableViewCell.swift
//  MovieReviews
//
//  Created by Viktor Rezvantsev on 27.07.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewPhoto: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    private var url: URL?


    override func prepareForReuse() {
        super.prepareForReuse()
    }
}


// MARK: - Configure

extension ReviewTableViewCell {
    func configure(with review: Review) {
        titleLabel.text = "\(review.title)"
        detailsLabel.text = "\(review.summaryShort)"
        authorLabel.text = "\(review.byline)"
        dateLabel.text = "date"
        setImage(urlString: review.pictureURL)
    }


    func setImage(urlString: String){
        guard let imageURL = URL(string: urlString) else {
            return
        }
        url = imageURL

        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let data = try? Data(contentsOf: imageURL) else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.imageView?.image = UIImage(data: data)

            }
        }
    }
}
