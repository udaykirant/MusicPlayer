//
//  SongsListInteractor.swift
//  MusicPlayer
//
//  Created by Uday Kiran on 15/03/18.
//  Copyright © 2018 UK. All rights reserved.
//

import Foundation

class SongsListInteractor {
    func getSongsList(_ completion: @escaping (_ songs : [Song], _ error: Error?)-> Void) {
        APIClient.getRequestWithURL(Constants.SongsListAPI) { (data, error) in
            guard let _data = data else {
                completion([], error)
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: _data, options: .mutableContainers) as? [String:AnyObject]  else {
                completion([], error)
                return
            }
            
             //parsing required data from the JSON
            guard let jsonData = json?["data"] as? [Dictionary<String, AnyObject>] else {
                completion([], error)
                return
            }
            
            do {
                if let songsData = try? JSONSerialization.data(withJSONObject: jsonData, options: JSONSerialization.WritingOptions.prettyPrinted) {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.serverFormate)
                    let songs = try decoder.decode([Song].self, from: songsData)
                    completion(songs, error)
                } else {
                    completion([], error)
                }
            } catch {
                completion([], error)
            }
        }
    }
}
