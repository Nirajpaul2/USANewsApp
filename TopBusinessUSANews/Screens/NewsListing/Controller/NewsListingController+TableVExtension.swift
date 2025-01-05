//
//  NewsListingController+TableVExtension.swift
//  TopBusinessUSANews
//
//  Created by niraj paul on 05/01/25.
//

import UIKit

// Define an enum for row heights
enum TableViewHeight {
    static let defaultRow: CGFloat = 104
}

// MARK: Tableview delegates and datasource
extension NewsListingController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.noOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let description = viewModel?.fetchNews(index: indexPath.row)?.description, !description.isEmpty else {
            return TableViewHeight.defaultRow
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             configureNewsCell(for: tableView, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let news = viewModel?.fetchNews(index: indexPath.row)
        viewModel?.navigateToDetailPage(data: news)
    }
}

//MARK: Cell configuration
private extension NewsListingController {
    
    func configureNewsCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let newsCell = tableView.dequeueReusableCell(withIdentifier: Constants.TVCellNibName.newsTableViewCell) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        newsCell.loadCellData(news: viewModel?.fetchNews(index: indexPath.row))
        return newsCell
    }
}
