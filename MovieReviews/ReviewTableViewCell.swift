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
        layer.masksToBounds = false
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

    func resizeImage(at url: URL, for size: CGSize) -> UIImage? {
        guard let image = UIImage(contentsOfFile: url.path) else {
            return nil
        }

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }

    override open var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 10
            frame.origin.x += 10
            frame.size.height -= 15
            frame.size.width -= 2 * 10
            super.frame = frame
        }
    }
}
