//
//  JsonFileReader.swift
//  TopBusinessUSANews
//
//  Created by niraj paul on 05/01/25.
//

import Foundation

class JsonHelper {
    /// Fetch the data for the corresponding Mock file.
    /// - Parameter fileName: Corresponding fileName
    func fetchData(_ fileName: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
        if let path = bundle.path(forResource: fileName,
                                  ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {}
        }
        return nil
    }
}
