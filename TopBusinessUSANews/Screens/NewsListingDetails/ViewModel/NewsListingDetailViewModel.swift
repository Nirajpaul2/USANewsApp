//
//  NewsListingDetailViewModel.swift
//  TopBusinessUSANews
//
//  Created by niraj paul on 05/01/25.
//

import Foundation

protocol NewsListingDetailViewModelProtocol {
    func getNewsData() -> News?
    func getAuthorName() -> String
    func getDescription() -> String
}

class NewsListingDetailViewModel: NewsListingDetailViewModelProtocol {
    private var news: News?
    init(news: News?) {
        self.news = news
    }
    
    func getNewsData() -> News? {
        return news
    }
    
    func getAuthorName() -> String {
        return news?.author ?? "N/A"
    }
    
    func getDescription() -> String {
        return news?.description ?? "N/A"
    }
}
