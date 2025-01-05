//
//  NewsListingDetailController.swift
//  TopBusinessUSANews
//
//  Created by niraj paul on 05/01/25.
//

import UIKit

class NewsListingDetailController: UIViewController {

    @IBOutlet weak private var imageV: UIImageView!
    @IBOutlet weak private var lblAuthor: UILabel!
    @IBOutlet weak private var lblDescription: UILabel!
    
    var viewModel: NewsListingDetailViewModelProtocol?
    
    //MARK: Initializers
    static func create(news: News?) -> NewsListingDetailController {
        let viewController = Storyboard.main.instantiateVC(NewsListingDetailController.self)
        viewController.viewModel = NewsListingDetailViewModel(news: news)
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        navigationItem.title = "News Detail"
    }
    
    func loadData() {
        imageV.downloadImage(from: viewModel?.getNewsData()?.urlToImage ?? "") { [weak self] response in
            DispatchQueue.main.async {
                self?.imageV.image = response.status ? response.image : UIImage(named: "noImage")
            }
        }
        lblAuthor.text = viewModel?.getAuthorName()
        lblDescription.text = viewModel?.getDescription()
    }
}
