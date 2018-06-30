//
//  MainCacheList.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 26/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

typealias JSON = [String : Any]

class MainCache {

    /// Fetches main cache list from network and invokes completion handler
    /// Any error while fetching the list would result in error
    class func getFromNetwork(urlString: String,
                        completion: @escaping(Set<CacheItem>?) -> Void
        ) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) {
            (result: Result<JSON>) in
            switch result {
            case .success(let json):
                guard let items = json["items"] as? [JSON]
                    else {
                        completion(nil)
                        return
                }
                completion(items.mapSet { CacheItem($0) })

            case .failure(_): completion(nil)
            }
        }.resume()
    }
}
