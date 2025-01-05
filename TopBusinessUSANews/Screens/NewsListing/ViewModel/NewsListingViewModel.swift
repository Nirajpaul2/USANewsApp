//
//  NewsListingViewModel.swift
//  TopBusinessUSANews
//
//  Created by niraj paul on 05/01/25.
//

import Foundation

class NewsListingViewModel {
    
    private let controller: NewsListingViewProtocol?
    private let viewService: NewsListingViewServiceProtocol?
    private let navigation: NewsListingNavigationProtocol?
    var news: [News] = []
    
    init(controller: NewsListingViewProtocol?, viewService: NewsListingViewServiceProtocol? = NewsListingViewService(), navigation: NewsListingNavigationProtocol?) {
        self.controller = controller
        self.viewService = viewService
        self.navigation = navigation
    }
}

extension NewsListingViewModel: NewsListingViewModelProtocol {
    func navigateToDetailPage(data: News?) {
        navigation?.navigateToDetailPage(data: data)
    }
    
    func fetchNews(index: Int) -> News? {
        return news[safe: index]
    }
    
    
    func noOfRowsInSection() -> Int {
        return news.count
    }
    
    func fetchData() async {
        self.controller?.startProgressHub()
        do {
            let newsData = try await viewService?.getNewsData(url: Constants.url)
            self.news = newsData?.articles ?? []
            DispatchQueue.main.async {
                self.controller?.loadData()
                self.controller?.stopProgressHub()
            }
        } catch {
            print("Error fetching news data: \(error)")
        }
        
    }
}
