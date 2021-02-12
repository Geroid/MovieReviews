//
//  NYTimesAPI.swift
//  MovieReviews
//
//  Created by Viktor Rezvantsev on 25.07.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import Alamofire

enum NYTimesAPIKeys {
    static let apiKeyParam = "api-key"
    static let apiKey = "hb8QEYaG2fApIODvOISXAc1yBKyY1LZe"
    static let host = "https://api.nytimes.com/svc/movies/v2/"
}

enum APIError: Error {
    case resultParsingFailed
    case dataCorrupted
}

class NYTimesAPI {
    
    var session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
    var mapper: CriticMapper
    
    init(mapper: CriticMapper = CriticMapper()) {
        self.mapper = mapper
    }
    
    
    func getCritics(completion: ((Result<[Critic], Error>) -> Void)?) {
        let request = getRequest(endpoint: "critics/all.json")!
        session.dataTask(with: request) { [mapper] data, response, error in
            if let currentError = error {
                completion?(.failure(currentError))
                return
            }
            
            guard
                let resultData = data,
                let criticsJson = try? JSONSerialization.jsonObject(with: resultData, options: []) as? [String: Any],
                let criticsListData = criticsJson["results"] as? [[String:Any]]
                else {
                    completion?(.failure(APIError.resultParsingFailed))
                    return
            }
            let critics: [Critic] = criticsListData.compactMap { try? mapper.convertCritic(from: $0)}
            completion?(.success((critics)))
        }.resume()
    }
    
    func getReviews(offset: Int, completion: ((Result<[Review], Error>) -> Void)?) {
        let request = getRequest(endpoint: "reviews/all.json", params: ["offset" : offset])!
        session.dataTask(with: request) { [mapper] data, response, error in
            if let currentError = error {
                completion?(.failure(currentError))
                return
            }
            
            guard
                let resultData = data,
                let reviewsJson = try? JSONSerialization.jsonObject(with: resultData, options: []) as? [String:Any],
                let reviewListData = reviewsJson["results"] as? [[String: Any]]
                else {
                    completion?(.failure(APIError.resultParsingFailed))
                    return
            }
            
            let reviews: [Review] = reviewListData.compactMap{ try? mapper.convertReview(from: $0)}
            completion?(.success((reviews)))
        }.resume()
    }
    
    func searchReviews(query: String, completion: ((Result<[Review], Error>) -> Void)?) {
        let request = getRequest(endpoint: "reviews/search.json?", params: ["query": query])!
        session.dataTask(with: request) {[mapper] data, response, error in
            if let currentError = error {
                completion?(.failure(currentError))
                return
            }
            
            guard
                let resultData = data,
                let reviewsJson = try? JSONSerialization.jsonObject(with: resultData, options: []) as? [String:Any],
                let reviewListData = reviewsJson["results"] as? [[String: Any]]
                else {
                    completion?(.failure(APIError.resultParsingFailed))
                    return
            }
            
            let reviews: [Review] = reviewListData.compactMap{ try? mapper.convertReview(from: $0)}
            completion?(.success((reviews)))
        }.resume()
    }

    func searchCritics(reviewer: String, completion: ((Result<[Critic], Error>) -> Void)?) {
        let request = getRequest(endpoint: "critics", params: ["reviewer" : reviewer])!
        session.dataTask(with: request) {[mapper] data, response, error in
            if let currentError = error {
                completion?(.failure(currentError))
                return
            }

            guard
                let resultData = data,
                let criticsJson = try? JSONSerialization.jsonObject(with: resultData, options: []) as? [String: Any],
                let criticListData = criticsJson["results"] as? [[String:Any]]
                else {
                    completion?(.failure(APIError.resultParsingFailed))
                    return
            }

            let critics: [Critic] = criticListData.compactMap{ try?
                mapper.convertCritic(from: $0)}
            completion?(.success(critics))
        }.resume()
    }
    
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
        guard var components = URLComponents(string: NYTimesAPIKeys.host) else {
            return nil
        }
        
        var requestParams = params
        requestParams[NYTimesAPIKeys.apiKeyParam] = NYTimesAPIKeys.apiKey
        
        components.path.append(endpoint)
        components.queryItems = requestParams.map { key, value in
            URLQueryItem(name: key, value: String(describing: value))
        }
        
        return components.url
    }
}
