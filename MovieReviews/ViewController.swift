//
//  ViewController.swift
//  MovieReviews
//
//  Created by Viktor Rezvantsev on 24.07.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum colors {
        static let orange = UIColor(red: 0.97, green: 0.63, blue: 0.45, alpha: 1.00)
        static let blue = UIColor(red: 0.71, green: 0.89, blue: 0.98, alpha: 1.00)
    }
    
    // MARK: - Outlets

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var customNavbar: UIView!
    @IBOutlet var contentView: UIView!

    private var reviewTableVC : UIViewController!
    private var criticsCollectionVC : UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureReviewTableViewController()
    }

    // MARK: - IBActions
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            customizeNavBar(index: 0, color: colors.orange)
            configureReviewTableViewController()
            self.criticsCollectionVC.remove()
        case 1:
            customizeNavBar(index: 1, color: colors.blue)
            configureCriticListViewController()
            self.reviewTableVC.remove()
        default:
            break
        }
    }

    // MARK: - Configure Navbar and View Controllers

    func customizeNavBar(index: Int, color: UIColor) {
        headerLabel.text = segmentedControl.titleForSegment(at: index)
        segmentedControl.backgroundColor = color
        customNavbar.backgroundColor = color
    }


    func configureReviewTableViewController() {
        let controller = storyboard?.instantiateViewController(identifier: "ReviewTableViewController")
        reviewTableVC = controller!
        addChild(reviewTableVC)
        contentView.addSubview(reviewTableVC.view)
        reviewTableVC.didMove(toParent: self)
    }

    func configureCriticListViewController() {
        let controller = storyboard?.instantiateViewController(identifier: "CriticsListViewController")
        criticsCollectionVC = controller!
        addChild(criticsCollectionVC)
        contentView.addSubview(criticsCollectionVC.view)
        criticsCollectionVC.didMove(toParent: self)
    }


}

extension UIViewController {
    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}


