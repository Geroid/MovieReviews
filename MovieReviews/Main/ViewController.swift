//
//  ViewController.swift
//  MovieReviews
//
//  Created by Viktor Rezvantsev on 24.07.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var customNavbar: UIView!
    @IBOutlet var contentView: UIView!
    
    // MARK: - Properties

    private var reviewTableVC : UIViewController!
    private var criticsCollectionVC : UIViewController!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureReviewTableViewController()
    }


    // MARK: - Actions
       @IBAction func indexChanged(_ sender: UISegmentedControl) {
           switch segmentedControl.selectedSegmentIndex {
           case 0:
               customizeNavBar(index: 0, color: Colors.orange)
               configureReviewTableViewController()
               self.criticsCollectionVC.remove()
           case 1:
               customizeNavBar(index: 1, color: Colors.blue)
               configureCriticListViewController()
               self.reviewTableVC.remove()
           default:
               break
           }
       }
    
    // MARK: - Configure Navbar and View Controllers

    private func customizeNavBar(index: Int, color: UIColor) {
        headerLabel.text = segmentedControl.titleForSegment(at: index)
        segmentedControl.backgroundColor = color
        customNavbar.backgroundColor = color
    }


    private func configureReviewTableViewController() {
        let controller = storyboard?.instantiateViewController(identifier: "ReviewTableViewController")
        reviewTableVC = controller!
        addChild(reviewTableVC)
        contentView.addSubview(reviewTableVC.view)
        reviewTableVC.didMove(toParent: self)
    }

    private func configureCriticListViewController() {
        let controller = storyboard?.instantiateViewController(identifier: "CriticsListViewController")
        criticsCollectionVC = controller!
        addChild(criticsCollectionVC)
        contentView.addSubview(criticsCollectionVC.view)
        criticsCollectionVC.didMove(toParent: self)
    }

}

