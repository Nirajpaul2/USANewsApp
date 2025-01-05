//
//  ImageDownloader.swift
//  TopBusinessUSANews
//
//  Created by niraj paul on 05/01/25.
//

import Foundation
import UIKit

class ImageDownloader {
    static var shared = ImageDownloader()
    private let cache = NSCache<NSString, NSData>()
    private  init() {}
    
    // get image w.r.t keys
    private func loadImageFromCache(key:NSString)->UIImage? {
        if let cachedVersion = cache.object(forKey: key) {
            return UIImage(data: cachedVersion as Data)
        }
        return nil
    }
    
    // set Image into cache w.r.t keys
    private func setImageInCache(data: NSData, key:NSString) {
        cache.setObject(data, forKey: key)
    }
    
    // method tto download image and return status
    func downloadImage(from URLString: String, with completion: @escaping (_ response: (status: Bool, image: UIImage? ) ) -> Void) {
        
        // check URL is valid or not
        guard let url = URL(string: URLString) else {
            completion((status: false, image: nil))
            return
        }
        
        // check image exist in caches
        if let image = loadImageFromCache(key: url.absoluteString as NSString) {
            completion((status: true, image: image))
            return
        }
        
        // download image from URL
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion((status: false, image: nil))
                return
            }
            
            guard let httpURLResponse = response as? HTTPURLResponse,
                  httpURLResponse.statusCode == 200,
                  let data = data else {
                      completion((status: false, image: nil))
                      return
                  }
            
            let image = UIImage(data: data)
            self.setImageInCache(data: data as NSData, key: url.absoluteString as NSString)
            completion((status: true, image: image))
        }.resume()
    }
}

extension UIImageView {
    // return image sttatus w.r.t URLs
    func downloadImage(from URLString: String, with completion: @escaping (_ response: (status: Bool, image: UIImage? ) ) -> Void) {
        ImageDownloader.shared.downloadImage(from: URLString, with: completion)
    }
}
