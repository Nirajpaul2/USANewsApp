//
//  StoryboardUtility.swift
//  TopBusinessUSANews
//
//  Created by niraj paul on 05/01/25.
//

import Foundation
import UIKit

enum Storyboard: String {
    case main = "Main"
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func instantiateVC<T: UIViewController>(_ objectClass: T.Type) -> T {
        let storyBoard = self.instance
        return storyBoard.instantiateViewController(withIdentifier: objectClass.className) as! T
    }
}
