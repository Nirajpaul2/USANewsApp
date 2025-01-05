//
//  Constants.swift
//  TopBusinessUSANews
//
//  Created by niraj paul on 05/01/25.
//

import Foundation

struct Constants {
    private static let key = "c9fef69ccb5f47f8b109dadc94a551b4"
    private static let baseURL = "https://newsapi.org"
    static let url = "\(baseURL)/v2/top-headlines?country=us&category=business&apiKey=\(key)"
    
    struct TVCellNibName {
        static let newsTableViewCell = "NewsTableViewCell"
    }
}
