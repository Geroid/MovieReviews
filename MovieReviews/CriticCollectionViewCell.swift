//
//  CriticCollectionViewCell.swift
//  MovieReviews
//
//  Created by Viktor Rezvantsev on 27.07.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import UIKit

class CriticCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var criticName: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

    //MARK: - Extension

extension CriticCollectionViewCell {
    
    func configure(with model: Critic) {
        criticName.text = "\(model.name)"
        setImage(urlString: model.pictureURL)
    }
    
    private func setImage(urlString: String){
        guard let imageURL = URL(string: urlString) else {
            return
        }
        
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
