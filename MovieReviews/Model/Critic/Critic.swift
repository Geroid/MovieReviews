//
//  Critic.swift
//  MovieReviews
//
//  Created by Viktor Rezvantsev on 31.08.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import Foundation

struct Critic: Codable {
    var name: String
    var status: String
    var bio: String?
    var pictureURL: String?
}
