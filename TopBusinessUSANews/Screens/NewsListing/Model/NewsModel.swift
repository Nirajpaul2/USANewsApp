//
//  NewsModel.swift
//  TopBusinessUSANews
//
//  Created by niraj paul on 05/01/25.
//

import Foundation

// MARK: - News
struct NewsData: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [News]?
}

// MARK: - Article
struct News: Decodable {
    let source: Source?
    let author: String?
    let title, description: String?
    let url: String?
    let urlToImage: String?
    var publishedAt: Date
    let content: String?
}

// MARK: - Source
struct Source: Decodable {
    let id: String?
    let name: String?
}
