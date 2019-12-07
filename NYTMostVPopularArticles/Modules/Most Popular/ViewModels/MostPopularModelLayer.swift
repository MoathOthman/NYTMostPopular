//
//  MostPopularModelLayer.swift
//  NYTMostVPopularArticles
//
//  Created by Moath_Othman on 12/6/19.
//  Copyright © 2019 moath. All rights reserved.
//

import Foundation
import RxSwift

protocol MostPopularModelLayerProtocol {
    func getArticles() -> Observable<[Article]?>
}

class MostPopularModelLayer: MostPopularModelLayerProtocol {

    let api: APIClient

    init(api: APIClient) {
        self.api = api
    }

    func getArticles() -> Observable<[Article]?> {
        return api
            .getMostPopularArticles(period: "1")
            .map(mapJsonToArticle)
    }

    private func mapJsonToArticle(response: Any) -> [Article]? {
        if let responseUnwrapped = response as? [String: Any] {
            let decoder = JSONDecoder()
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: responseUnwrapped, options: .fragmentsAllowed)
                if let apiResponse = try? decoder.decode(ArticlesResponse.self, from: jsonData) {
                    return apiResponse.results
                }
            } catch {
                return nil
            }
        }
        return nil
    }
}
