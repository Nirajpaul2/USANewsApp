//
//  TopBusinessUSANewsTests.swift
//  TopBusinessUSANewsTests
//
//  Created by niraj paul on 05/01/25.
//

import XCTest
@testable import TopBusinessUSANews

final class TopBusinessUSANewsTests: XCTestCase {
    
    var viewModel: NewsListingViewModel!
    var mockController: MockNewsListingView!
    var mockService: MockNewsListingViewService!
    var mockNavigation: MockNewsListingNavigation!
    var newsData: NewsData?
    
    override func setUpWithError() throws {
        mockController = MockNewsListingView()
        mockService = MockNewsListingViewService()
        mockNavigation = MockNewsListingNavigation()
        viewModel = NewsListingViewModel(controller: mockController, viewService: mockService, navigation: mockNavigation)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockService = nil
        mockNavigation = nil
        mockController = nil
    }
    
    func testFetchData_Success() async throws {
        // Arrange
        mockService.mockNewsData = MockHelper().setUpNewsData()
        mockService.shouldThrowError = false
        
        let expectation = self.expectation(description: "Error handled gracefully")

        // Act
        await viewModel.fetchData()
        
        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.mockController.progressHubStart ?? false)
            XCTAssertTrue(self.mockController.progressHubStop ?? false)
            XCTAssertTrue(self.mockController.didCallLoadData)
            expectation.fulfill()
        }
        await fulfillment(of: [expectation])
    }
    
    func testFetchDataFailure() async {
        // Arrange
        mockService.shouldThrowError = true
        
        // Act
        await viewModel.fetchData()
        
        // Assert
        XCTAssertEqual(viewModel.noOfRowsInSection(), 0, "News count should be 0 when an error occurs.")
        XCTAssertFalse(mockController.didCallLoadData, "loadData should not be called when an error occurs.")
    }
    
    func testNavigateToDetailPage() {
        // Arrange
        let news = MockHelper().setUpNewsData()
        
        // Act
        viewModel.navigateToDetailPage(data: news?.articles?.first)
        
        // Assert
        XCTAssertTrue(mockNavigation.didCallNavigateToDetailPage, "navigateToDetailPage should be called.")
        XCTAssertEqual(mockNavigation.passedData?.title, "Biden blocks Japan’s Nippon from taking over US Steel - CNN", "Passed data should match the input.")
    }
    
    func testFetchNews() {
        
        viewModel.news = MockHelper().setUpNewsData()?.articles ?? []
        // Act
        let news = self.viewModel.fetchNews(index: 0)
        let rowCount = self.viewModel.noOfRowsInSection()
        
        XCTAssertEqual(news?.title, "Biden blocks Japan’s Nippon from taking over US Steel - CNN", "Fetched news should match the first article in the list.")
        
        XCTAssertEqual(rowCount, 20, "Number of rows should match the count of news articles.")
        
        
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
