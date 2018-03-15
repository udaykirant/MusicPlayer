//
//  Song.swift
//  MusicPlayer
//
//  Created by Uday Kiran on 14/03/18.
//  Copyright © 2018 UK. All rights reserved.
//

import Foundation

struct Song: Codable
{
    var id: String
    var name: String
    var audioLink: URL
    var createdOn: Date
    var modifiedOn: Date
    var picture: Picture
    var author: Author
    
    private enum CodingKeys: String, CodingKey
    {
        case id
        case name
        case createdOn
        case modifiedOn
        case audioLink
        case picture
        case author
    }
}

