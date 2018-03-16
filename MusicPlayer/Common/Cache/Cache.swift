//
//  Cache.swift
//  MusicPlayer
//
//  Created by Uday Kiran on 16/03/18.
//  Copyright © 2018 UK. All rights reserved.
//

import Foundation
import UIKit

class Cache {
    static let shared = Cache()
    var imageCache = NSCache<NSString, UIImage>()
    
}
