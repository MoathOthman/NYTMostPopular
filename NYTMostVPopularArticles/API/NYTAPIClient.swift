//
//  NYTAPIClient.swift
//  NYTMostVPopularArticles
//
//  Created by Moath_Othman on 12/5/19.
//  Copyright © 2019 moath. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

protocol APIClient {
    func getMostPopularArticles(period: String) -> Observable<Any>
}

class NYTAPIClient: APIClient {

    struct Cosntants {
        static let baseURL = "https://api.nytimes.com/svc/"
        static let APIKey = "ReF1cYEk6EGjiNzMxIbATloGhiCcB9xE"
    }

    enum Path {
        static func viewed(period: String) -> String {
            return "mostpopular/v2/viewed/" + period + ".json"
        }
    }

    let session = URLSession.shared

    private var query: String!

    func getMostPopularArticles(period: String) -> Observable<Any> {
        query = appendClientIdAndSecret("")
        return request(url: Cosntants.baseURL + Path.viewed(period: period), query: query)
    }

    private func request(url: String, query: String?) -> Observable<Any> {
        var urlComponents = URLComponents(string: url)
        urlComponents?.query = query
        let url = urlComponents?.url
        return session.rx.json(url: url!)
    }

    private func appendClientIdAndSecret(_ query: String) -> String {
        return query + "api-key=\(NYTAPIClient.Cosntants.APIKey)"
    }
}
