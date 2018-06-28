//
//  NSMenu+Extras.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 27/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

extension NSMenu {
    func removeCacheMenuItem(cacheId: String) {
        items
            .first(where: { $0.cacheView?.cacheId == cacheId })
            .map { removeItem($0) }
    }

    func menuItem(for cacheItem: CacheItem) -> NSMenuItem? {
        return items.first(where: { $0.cacheView?.cacheId == cacheItem.id })
    }
}
