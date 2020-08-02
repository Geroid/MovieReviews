//
//  ViewController.swift
//  MovieReviews
//
//  Created by Viktor Rezvantsev on 24.07.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum Segues {
        static let toReviewTableView = "ToReviewTableView"
        static let toCriticCollectionView = "ToCriticsCollectionView"
    }
    
    // MARK: - Outlets

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var customNavbar: UIView!

    private let reviewTableVC = ReviewTableViewController()
    private let criticsCollectionVC = CriticsListViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.backgroundColor = UIColor(red: 0.97, green: 0.63, blue: 0.45, alpha: 1.00)
        customNavbar.backgroundColor = UIColor(red: 0.97, green: 0.63, blue: 0.45, alpha: 1.00)
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            headerLabel.text = segmentedControl.titleForSegment(at: 0)
            segmentedControl.backgroundColor = UIColor(red: 0.97, green: 0.63, blue: 0.45, alpha: 1.00)
            customNavbar.backgroundColor = UIColor(red: 0.97, green: 0.63, blue: 0.45, alpha: 1.00)
        case 1:
            headerLabel.text = segmentedControl.titleForSegment(at: 1)
            segmentedControl.backgroundColor = UIColor(red: 0.71, green: 0.89, blue: 0.98, alpha: 1.00)
            customNavbar.backgroundColor = UIColor(red: 0.71, green: 0.89, blue: 0.98, alpha: 1.00)
//            let controller = criticsListViewController()
//            navigationController?.pushViewController(controller, animated: false)
        default:
            break
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.toReviewTableView {
//            addChild(reviewTableVC)
            addChild(reviewTableVC)
        } else if segue.identifier == Segues.toCriticCollectionView {
//            view.addSubview(criticsCollectionVC.view)
        }
    }
    
  
    
    private func criticsListViewController() -> CriticsListViewController {
        let identifier = "CriticsListViewController"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? CriticsListViewController else {
            fatalError("Unable to instantiate ViewController with identifier: \(identifier)")
        }
        return controller
    }
    
    
    
}



