//
//  Author.swift
//  MusicPlayer
//
//  Created by Uday Kiran on 14/03/18.
//  Copyright © 2018 UK. All rights reserved.
//

import Foundation

class Author: Codable {
    var name: String
    var picture: Picture
    
    private enum CodingKeys: String, CodingKey
    {
        case name
        case picture
    }
}
