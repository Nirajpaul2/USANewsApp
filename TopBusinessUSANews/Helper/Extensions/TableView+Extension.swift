//
//  TableView+Extension.swift
//  TopBusinessUSANews
//
//  Created by niraj paul on 05/01/25.
//

import UIKit

extension UITableView {
    func registerXIBCell(type: UITableViewCell.Type) {
        let identifier = String(describing: type)
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
}
