//
//  CacheList.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 26/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

protocol CacheListDelegate: class {
    func cacheListSizeUpdatedFor(cache: CacheItem)
}

class CacheList {
    var list: [CacheItem]
    weak var delegate: CacheListDelegate?

    init(_ list: [CacheItem]) {
        self.list = list
    }

    func updateSizes() {
        let dispatchGroup = DispatchGroup()
        for (i, item) in list.enumerated() {
            DispatchQueue.global().async {
                dispatchGroup.enter()
                var item = item
                item.size = item.locationSize
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                    self.list[i] = item
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            print("Search complete")
        }

    }
}
