//
//  StatusItemController.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 26/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

class StatusItemController {
    private let statusItem: NSStatusItem
    private let loadingMenuItem = NSMenuItem(view: LoadingMenuView.initialise())

    private var list: Set<CacheItem>? {
        didSet {
            assert(list != nil)

            // If list has old value then update is done on LOW priority queue
            let qos: DispatchQoS.QoSClass = oldValue == nil ? .userInitiated : .background
            self.calculateSizeAndUpdateMenu(queue: .global(qos: qos))
        }
    }

    init() {
        statusItem = NSStatusBar.system.statusItem(withLength: -1)
        statusItem.button?.image = #imageLiteral(resourceName: "StatusIcon")
        statusItem.menu = NSMenu(items: [loadingMenuItem, .separator(), .quit])
    }


    func updateMainListFromNetwork() {
        let githubURL = "https://raw.githubusercontent.com/kaunteya/MacCacheCleaner/master/Source.json"
        MainCache.getFromNetwork(urlString: githubURL) {
            [unowned self] list in
            if let list = list { self.list = list }
        }
    }

    private var isLoadingViewVisible: Bool {
        return statusItem.menu?.items
            .contains(where: {  $0.view is LoadingMenuView })
            ?? false
    }

    func calculateSizeAndUpdateMenu(queue: DispatchQueue) {
        let dispatchGroup = DispatchGroup()
        list?.forEach { item in
            queue.async {
                dispatchGroup.enter()
                let item = item.itemWithRelcalculatedSize()
                DispatchQueue.main.async { [unowned self] in
                    dispatchGroup.leave()
                    self.updateMenuItemFor(cache: item)
                }
            }
        }
        dispatchGroup.notify(queue: .main) { [unowned self] in
            if self.isLoadingViewVisible {
                self.statusItem.menu?.removeItem(self.loadingMenuItem)
            }
        }
    }

    private func updateMenuItemFor(cache: CacheItem) {
        assert(cache.size != nil)
        guard cache.size! > 0 else { return }
        if let menuItem = statusItem.menu?.menuItem(for: cache) {
            //If menu is already present, update size
            menuItem.cacheView?.update(size: cache.size!.bytesToReadableString)
        } else {
            //If menu is not present, create one and add
            let cacheMenuItem = NSMenuItem(view: CacheMenuView.initialize(with: cache))
            cacheMenuItem.cacheView?.delegate = self
            statusItem.menu?.insertItem(cacheMenuItem, at: 0)
        }
    }
}

extension StatusItemController: CacheMenuViewDelegate {
    func itemRemoved(_ cacheId: String) {
        guard let cacheItem = list?.first(where: { $0.id == cacheId }) else {
            return
        }
        cacheItem.deleteCache(complete: {
            print("Deletion complete")
        })
        statusItem.menu?.removeCacheMenuItem(cacheId: cacheId)
    }
}
