//
//  ArrayExtension.swift
//  TopBusinessUSANews
//
//  Created by niraj paul on 05/01/25.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
