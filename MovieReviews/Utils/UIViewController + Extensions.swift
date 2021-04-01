//
//  UIViewController + Extensions.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 26.02.2021.
//  Copyright © 2021 Viktor Rezvantsev. All rights reserved.
//

import UIKit

extension UIViewController {
    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
