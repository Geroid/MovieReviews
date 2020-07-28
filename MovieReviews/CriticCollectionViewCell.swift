//
//  CriticCollectionViewCell.swift
//  MovieReviews
//
//  Created by Viktor Rezvantsev on 27.07.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import UIKit

class CriticCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var criticName: UILabel!

    private let cornerRadius: CGFloat = 5

    private var url: URL?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension CriticCollectionViewCell {

    func confure(with model: Critic) {
        criticName.text = "\(model.name)"
        setImage(urlString: model.pictureURL)
    }

    private func setImage(urlString: String){
        guard let imageURL = URL(string: urlString) else {
            return
        }
        url = imageURL

        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let data = try? Data(contentsOf: imageURL) else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.profileImage?.image = UIImage(data: data)

            }
        }
    }
}
