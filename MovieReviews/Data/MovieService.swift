//
//  MovieService.swift
//  MovieReviews
//
//  Created by Viktor Rezvantsev on 25.07.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import Foundation

enum MovieServiceKeys {
    static let apiKeyParam = "api-key"
    static let apiKey = "hb8QEYaG2fApIODvOISXAc1yBKyY1LZe"
    static let host = "https://api.nytimes.com/svc/movies/v2/"
}

enum APIError: Error {
    case resultParsingFailed
    case dataCorrupted
}

class MovieService {


    // MARK: -Helpers

    func getRequest(endpoint: String, params: [String:Any] = [:]) -> URLRequest? {
        guard let requestURL = requestURL(for: endpoint, params: params) else {
            return nil
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        return request
    }

    private func requestURL(for endpoint: String, params: [String:Any] = [:]) -> URL? {
        guard var components = URLComponents(string: MovieServiceKeys.host) else {
            return nil
        }

        var requestParams = params
        requestParams[MovieServiceKeys.apiKeyParam] = MovieServiceKeys.apiKey

        components.path.append(endpoint)
        components.queryItems = requestParams.map { key, value in
            URLQueryItem(name: key, value: String(describing: value))
        }

        return components.url
    }
}
