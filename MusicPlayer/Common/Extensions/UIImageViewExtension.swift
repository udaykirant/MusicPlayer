//
//  UIImageViewExtension.swift
//  MusicPlayer
//
//  Created by Uday Kiran on 15/03/18.
//  Copyright © 2018 UK. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(fromURL url: URL, completionBlock: ((Bool) -> ())? = nil)  {
        //Fetching images from cache
        if let cachedImage = Cache.shared.imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            completionBlock?(true)
            return
        }
        APIClient.getRequestWithURL(url.absoluteString) { (data, error) in
            guard let _data = data else {
                completionBlock?(false)
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: _data) {
                    //Caching images temporarily
                    Cache.shared.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    self.image = image
                    completionBlock?(true)
                }
            }
        }
    }
}
