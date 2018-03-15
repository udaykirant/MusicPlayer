//
//  Picture.swift
//  MusicPlayer
//
//  Created by Uday Kiran on 14/03/18.
//  Copyright © 2018 UK. All rights reserved.
//

import Foundation

class Picture: Codable {
    var small: URL
    var medium: URL
    var large: URL
    var extraSmall: URL
    var url: URL
    
    private enum CodingKeys: String, CodingKey
    {
        case small = "s"
        case medium = "m"
        case large = "l"
        case extraSmall = "xs"
        case url
    }
}
