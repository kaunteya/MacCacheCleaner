//
//  MainCacheList.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 26/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

typealias JSON = [String : Any]

/// Maintains the list of all possible caches that can be present in Mac
class MainCache {

    /// Fetches all possible caches in json format.
    /// Converts them to CacheItem list
    /// Stores them in list variable
    class func updateFromNetwork(completion: (_ list: Set<CacheItem>) -> Void) {
        let url = Bundle.main.url(forResource: "Source", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! JSON
        let items = json["items"] as! [JSON]
        let cacheItemList = items.map { CacheItem($0) }
        completion(Set(cacheItemList))
    }

    private class func getCacheListFromJSON(file name:String) -> Set<CacheItem> {
        let url = Bundle.main.url(forResource: name, withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! JSON
        let items = json["items"] as! [JSON]
        return items.mapSet { CacheItem($0) }
    }

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
