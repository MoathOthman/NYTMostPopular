//
//  Article.swift
//  NYTMostVPopularArticles
//
//  Created by Moath_Othman on 12/6/19.
//  Copyright © 2019 moath. All rights reserved.
//

import Foundation

struct ArticlesResponse: Codable {

    let copyright: String?
    let numResults: Int?
    let results: [Article]?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case copyright = "copyright"
        case numResults = "num_results"
        case results = "results"
        case status = "status"
    }
}

struct Article: Codable {

    let abstractField: String?
    let adxKeywords: String?
    let assetId: Int?
    let byline: String?
    let column: String?
    let desFacet: [String]?
    let geoFacet: [String]?
    let id: Int?
    let media: [Media]?
    let orgFacet: String?
    let perFacet: String?
    let publishedDate: String?
    let section: String?
    let source: String?
    let title: String?
    let type: String?
    let uri: String?
    let url: String?
    let views: Int?

    enum CodingKeys: String, CodingKey {
        case abstractField = "abstract"
        case adxKeywords = "adx_keywords"
        case assetId = "asset_id"
        case byline = "byline"
        case column = "column"
        case desFacet = "des_facet"
        case geoFacet = "geo_facet"
        case id = "id"
        case media = "media"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case publishedDate = "published_date"
        case section = "section"
        case source = "source"
        case title = "title"
        case type = "type"
        case uri = "uri"
        case url = "url"
        case views = "views"
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
