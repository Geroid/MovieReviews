//
//  CriticsViewController.swift
//  MovieReviews
//
//  Created by Viktor Rezvantsev on 27.07.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import UIKit

class CriticsViewController: UIViewController {
    
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileStatusLabel: UILabel!
    @IBOutlet weak var profileBioLabel: UILabel!
    
    var critic: Critic!
    var reviews: [Review] = []
    
    private var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(with: critic)
        profilePhoto.image = nil
    }
    
    func configure(with model: Critic) {
        profileName.text = "\(model.name)"
        profileStatusLabel.text = "\(model.status)"
        if(model.bio == "") {
            profileBioLabel.isHidden = true
        } else {
            profileBioLabel.text = "\(model.bio)"
        }
        setImage(urlString: model.pictureURL)
    }
    
}

extension CriticsViewController {
    
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
                self?.profilePhoto?.image = UIImage(data: data)
            }
        }
    }
    
}
