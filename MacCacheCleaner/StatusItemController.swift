//
//  StatusItemController.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 26/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

class StatusItemController {
    let statusItem: NSStatusItem
    var list: [CacheItem]? {
        willSet {
            assert(list == nil, "list must be set only once")
        }
        didSet {
            self.addNonZeroSizeItems(list: list!)
        }
    }
    
    init() {
        statusItem = NSStatusBar.system.statusItem(withLength: 30)
        statusItem.title = "AK"
        statusItem.menu = NSMenu()
    }

    func addNonZeroSizeItems(list: [CacheItem]) {
        let dispatchGroup = DispatchGroup()
        for item in list {
            DispatchQueue.global().async {
                dispatchGroup.enter()
                var item = item
                item.size = item.locationSize
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                    self.addMenuItem(cache: item)
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            print("Search complete")
        }
    }

    func addMenuItem(cache: CacheItem) {
        print("Adding \(cache.name)")
        let cacheMenuItem = NSMenuItem(cache: cache)
        cacheMenuItem.cacheView?.delegate = self
        statusItem.menu!.addItem(cacheMenuItem)
    }
}

extension StatusItemController: CacheMenuViewDelegate {
    func itemRemoved(_ cacheId: String) {
        
//        FileManager.default.removeIte
        statusItem.menu?.removeCacheMenuItem(cacheId: cacheId)
    }
}
