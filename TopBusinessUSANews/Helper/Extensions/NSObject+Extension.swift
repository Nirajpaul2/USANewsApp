//
//  NSObject+Extension.swift
//  TopBusinessUSANews
//
//  Created by niraj paul on 05/01/25.
//

import Foundation

extension NSObject {
    /**
     Variable to get class name
     - returns: Returns class name string
    */
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
