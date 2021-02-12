//
//  UIView+Extensions.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 08.02.2021.
//  Copyright © 2021 Viktor Rezvantsev. All rights reserved.
//

import UIKit

public extension UIView {
  func addSubviews(_ views: UIView...) {
    for view in views {
      addSubview(view)
    }
  }
}
