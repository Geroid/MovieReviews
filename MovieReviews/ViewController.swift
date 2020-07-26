//
//  ViewController.swift
//  MovieReviews
//
//  Created by Viktor Rezvantsev on 24.07.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let interitemSpasing: CGFloat = 10
    private let itemsPerRow: Int = 2
    @IBOutlet var segmentedControl: UISegmentedControl!
    //    private let cellReuseIdentifier = String(describing: CriticCollectionViewCell)

    var critics: [Critic] = []
    var reviews: [Review] = []
    var service = MovieService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        if (segmentedControl.numberOfSegments == 1) {
            navigationItem.title = segmentedControl.titleForSegment(at: 1)        } else {
            navigationItem.title = segmentedControl.titleForSegment(at: 0)
        }

        loadCritics()
        loadReviews()

    }



    func loadCritics() {
        service.getCritics { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let critics):
                self.critics = critics

            case .failure(let error):
                print(error.localizedDescription)
            }


        }
    }

    func loadReviews() {
        service.getReviews{ [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let reviews):
                self.reviews = reviews

            case .failure(let error):
                print(error.localizedDescription)
            }

        }
    }
}

