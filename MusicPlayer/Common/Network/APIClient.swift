//
//  APIClient.swift
//  MusicPlayer
//
//  Created by Uday Kiran on 14/03/18.
//  Copyright © 2018 UK. All rights reserved.
//

import Foundation

class APIClient {
    class func getRequestWithURL(_ urlPath: String, completion: @escaping (_ jsonResponse : Data?, _ error: Error?)-> Void) {
        guard let url = URL(string: urlPath) else {
            completion(nil, nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            guard let _data = data else {
                completion(nil, error)
                return
            }
            completion(_data, error)
        })
        task.resume()
    }
}
