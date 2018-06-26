//
//  MainCacheList.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 26/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

class MainCacheList {
    var list: [CacheItem]?

    func updateFromNetwork(completion: () -> Void) {
        let url = Bundle.main.url(forResource: "Source", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! JSON
        let items = json["items"] as! [JSON]
        let cacheItemList = items.map { CacheItem($0) }
        list = cacheItemList
        completion()
    }
}
