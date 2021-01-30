//
//  CriticsViewController.swift
//  MovieReviews
//
//  Created by Viktor Rezvantsev on 27.07.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import UIKit

class CriticsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileStatusLabel: UILabel!
    @IBOutlet weak var profileBioLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var criticsLabel: UILabel!

    // MARK:- Properties

    var critic: Critic!
    var reviews: [Review] = []
    private var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(with: critic)
    }

    // MARK: - Actions

    @IBAction func backButtonDidClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    func configure(with model: Critic) {
        criticsLabel.text = "\(model.name)"
        profileName.text = "\(model.name)"
        profileStatusLabel.text = "\(model.status)"
        if(model.bio == nil) {
            profileBioLabel.isHidden = true
        } else {
            profileBioLabel.text = "\(String(describing: model.bio ?? ""))"
        }
        setImage(urlString: model.pictureURL!)
    }
    
}

    // MARK: - Extension

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
