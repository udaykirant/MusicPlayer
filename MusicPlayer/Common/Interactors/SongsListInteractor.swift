//
//  SongsListInteractor.swift
//  MusicPlayer
//
//  Created by Uday Kiran on 15/03/18.
//  Copyright © 2018 UK. All rights reserved.
//

import Foundation

class SongsListInteractor {
    func getSongsList(_ completion: @escaping (_ songs : [Song])-> Void) {
        APIClient.getRequestWithURL(Constants.SongsListAPI) { (data) in
            guard let _data = data else {
                completion([])
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: _data, options: .mutableContainers) as? [String:AnyObject]  else {
                completion([])
                return
            }
            
             //parsing required data from the JSON
            guard let jsonData = json?["data"] as? [Dictionary<String, AnyObject>] else {
                completion([])
                return
            }
            
            do {
                if let songsData = try? JSONSerialization.data(withJSONObject: jsonData, options: JSONSerialization.WritingOptions.prettyPrinted) {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.serverFormate)
                    let songs = try decoder.decode([Song].self, from: songsData)
                    completion(songs)
                } else {
                    completion([])
                }
            } catch {
                print(error)
                completion([])
            }
        }
    }
}
