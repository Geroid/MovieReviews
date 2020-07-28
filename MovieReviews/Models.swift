//
//  Models.swift
//  MovieReviews
//
//  Created by Viktor Rezvantsev on 25.07.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import Foundation

struct Critic {
//    var id: Int
    var name: String
    var status: String
    var bio: String
    var pictureURL: String
}

struct Review {
    var title: String
    var summaryShort: String
    var byline: String
    var reviewURL: String
    var pictureURL: String
    var date: Date
}
