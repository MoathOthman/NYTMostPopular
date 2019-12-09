//
//  Article.swift
//  NYTMostVPopularArticles
//
//  Created by Moath_Othman on 12/6/19.
//  Copyright © 2019 moath. All rights reserved.
//

import Foundation

struct ArticlesResponse: Codable {

    let copyright: String
    let numResults: Int
    let results: [Article]
    let status: String

    enum CodingKeys: String, CodingKey {
        case copyright = "copyright"
        case numResults = "num_results"
        case results = "results"
        case status = "status"
    }
}

struct Article: Codable, Equatable {

    let abstractField: String
    let byline: String
    let id: Int
    //    let media: [Media?]
    let publishedDate: String
    let source: String
    let title: String
    let views: Int
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case abstractField = "abstract"
        case byline = "byline"
        case id = "id"
        //        case media = "media"
        case publishedDate = "published_date"
        case source = "source"
        case title = "title"
        case views = "views"
        case url = "url"

    }
}

struct Media: Codable {

    let approvedForSyndication: Int?
    let caption: String?
    let copyright: String?
    let mediametadata: [Mediametadata]?
    let subtype: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case approvedForSyndication = "approved_for_syndication"
        case caption = "caption"
        case copyright = "copyright"
        case mediametadata = "media-metadata"
        case subtype = "subtype"
        case type = "type"
    }
}

struct Mediametadata: Codable {
    let format: String?
    let height: Int?
    let url: String?
    let width: Int?
}
