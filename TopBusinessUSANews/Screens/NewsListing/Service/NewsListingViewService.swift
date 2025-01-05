//
//  HomeViewService.swift
//  TopBusinessUSANews
//
//  Created by niraj paul on 05/01/25.
//

import Foundation

protocol NewsListingViewServiceProtocol {
    func getNewsData(url: String) async throws -> NewsData?
}

class NewsListingViewService: NewsListingViewServiceProtocol {
    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func getNewsData(url: String) async throws -> NewsData? {
        do {
            let newsData: NewsData = try await apiManager.getData(url: url, httpsMethod: .get)
            return newsData
        } catch {
            throw DemoError.noData
        }
    }
}
