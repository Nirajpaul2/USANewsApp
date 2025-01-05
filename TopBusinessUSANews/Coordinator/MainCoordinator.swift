//
//  MainCoordinator.swift
//  TopBusinessUSANews
//
//  Created by niraj paul on 05/01/25.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigator: UINavigationController
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    
    func start() {
        let controller = NewsListingController.create(navigation: self)
        navigator.pushViewController(controller, animated: true)
    }
}

extension MainCoordinator: NewsListingNavigationProtocol {
    func navigateToDetailPage(data: News?) {
       let controller = NewsListingDetailController.create(news: data)
        navigator.pushViewController(controller, animated: true)
    }
}
