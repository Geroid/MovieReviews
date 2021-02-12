//
//  Review.swift
//  MovieReviews
//
//  Created by Viktor Rezvantsev on 31.08.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import Foundation

struct Review: Codable {
    var title: String
    var summaryShort: String?
    var byline: String?
    var reviewURL: String?
    var pictureURL: String
    var date: Date
}
