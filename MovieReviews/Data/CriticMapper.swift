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
            name: json["display_name"] as? String ?? "",
            status: json["status"] as? String ?? "",
            bio: json["bio"] as? String ?? "",
            pictureURL: img as? String ?? "")
    }

    func convertReview(from json: [String:Any]) throws -> Review {

        let link = json["link"]
        let reviewUrl = link.flatMap { ($0 as AnyObject)["url"] } as? String ?? ""
        let multimedia = json["multimedia"]
        let picruteUrl = multimedia.flatMap{ ($0 as AnyObject)["src"] } as? String ?? ""

        let publicationDate = json["publication_date"] as? String

        return Review(
            title: json["display_title"] as? String ?? "",
            summaryShort: json["summaty_short"] as? String ?? "",
            byline: json["byline"] as? String ?? "",
            reviewURL: reviewUrl,
            pictureURL: picruteUrl,
            date: publicationDate.flatMap{ DateHelper.dateFormatter.date(from: $0) } ?? Date() )
    }
}
