//
//  CriticMapper.swift
//  MovieReviews
//
//  Created by Viktor Rezvantsev on 26.07.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import Foundation

class CriticMapper {

    func convertCritic(from json: [String:Any]) throws -> Critic {

        let multimedia = json["multimedia"]
        let resource = multimedia.flatMap{ ($0 as AnyObject)["resource"] } as Any
        let img = (resource as AnyObject)["src"]

        return Critic(
//            id: 1,
            name: json["display_name"] as? String ?? "",
            status: json["status"] as? String ?? "",
            bio: json["bio"] as? String ?? "",
            pictureURL: img as? String ?? "")
    }
}
