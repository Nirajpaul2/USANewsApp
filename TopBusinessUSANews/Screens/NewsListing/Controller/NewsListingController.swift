//
//  NewsListingController.swift
//  TopBusinessUSANews
//
//  Created by niraj paul on 05/01/25.
//

import UIKit
import ProgressHUD

class NewsListingController: UIViewController {
    @IBOutlet weak var tblVNews: UITableView!
    
    var viewModel: NewsListingViewModelProtocol?
    
    //MARK: Initializers
    static func create(navigation: NewsListingNavigationProtocol) -> NewsListingController {
        let viewController = Storyboard.main.instantiateVC(NewsListingController.self)
        viewController.viewModel = NewsListingViewModel(controller: viewController, navigation: navigation)
        return viewController
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupListView()
        fetchNewsData()
        navigationItem.title = "Latest USA news"
    }
    
    func setupListView() {
        tblVNews.delegate = self
        tblVNews.dataSource = self
        tblVNews.registerXIBCell(type: NewsTableViewCell.self)
    }
    
    func fetchNewsData() {
        Task(priority: .background) {
            await viewModel?.fetchData()
        }
    }
}

extension NewsListingController: NewsListingViewProtocol {
    func loadData() {
        self.tblVNews.reloadData()
    }
    
    func startProgressHub() {
        ProgressHUD.progress(0.04)
    }
    
    func stopProgressHub() {
        ProgressHUD.dismiss()
    }
    
}

