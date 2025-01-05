//
//  MockClass.swift
//  TopBusinessUSANewsTests
//
//  Created by niraj paul on 05/01/25.
//

import Foundation
@testable import TopBusinessUSANews

class MockNewsListingView: NewsListingViewProtocol {
    var progressHubStart: Bool? = false
    var progressHubStop: Bool? = false

    var didCallLoadData = false
    
    func startProgressHub() {
        progressHubStart = true
    }
    
    func stopProgressHub() {
        progressHubStop = true
    }
    
    func loadData() {
        didCallLoadData = true
    }
}


// Mock JsonDecoderProtocol
class MockNewsListingViewService: NewsListingViewServiceProtocol {
    var mockNewsData: NewsData?
    var shouldThrowError = false

    func getNewsData(url: String) async throws -> NewsData? {
        if shouldThrowError {
            throw DemoError.noData
        }
        return mockNewsData
    }
}

class MockNewsListingNavigation: NewsListingNavigationProtocol {
    var didCallNavigateToDetailPage = false
    var passedData: News?

    func navigateToDetailPage(data: News?) {
        didCallNavigateToDetailPage = true
        passedData = data
    }
}

class MockHelper {
    func setUpNewsData() -> NewsData? {
        guard let data = JsonHelper().fetchData("NewsJsonData") else { return nil }
        let decoder = JSONDecoder()
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        decoder.dateDecodingStrategy = .formatted(inputDateFormatter)
        decoder.dateDecodingStrategy = .iso8601
        do {
           let data = try decoder.decode(NewsData.self, from: data)
            return data
        } catch {
            return nil
        }
    }
}
