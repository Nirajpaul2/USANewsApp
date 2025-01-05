//
//  NewsListingProtocol.swift
//  TopBusinessUSANews
//
//  Created by niraj paul on 05/01/25.
//

import Foundation

// Protocol for view
protocol NewsListingViewProtocol {
    func loadData()
    func startProgressHub()
    func stopProgressHub()
}

// Protocol for ViewModel
protocol NewsListingViewModelProtocol: NewsListingNavigationProtocol {
    func fetchData() async
    func noOfRowsInSection() -> Int
    func fetchNews(index: Int) -> News?
}


// Protocol for the navigation
protocol NewsListingNavigationProtocol {
    func navigateToDetailPage(data: News?)
}

