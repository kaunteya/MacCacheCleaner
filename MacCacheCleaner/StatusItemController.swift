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
    var list: Set<CacheItem>? {
        willSet {
            assert(list == nil, "list must be set only once")
        }
        didSet {
            self.updateList(list: list!)
        }
    }
    var timer: Timer!
    init() {
        statusItem = NSStatusBar.system.statusItem(withLength: -1)
        statusItem.button?.image = #imageLiteral(resourceName: "StatusIcon")
        statusItem.menu = NSMenu()
        addDefaultMenuItems()
    }

    var isLoadingViewPresent: Bool {
        return statusItem.menu?.item(at: 0)?.view is LoadingMenuView
    }

    func addDefaultMenuItems() {
        do {
            let infoMenuItem = NSMenuItem(view: LoadingMenuView.initialize())
            statusItem.menu?.addItem(infoMenuItem)
        }
        statusItem.menu?.addItem(.separator())
        do {
            let menuItem = NSMenuItem(title: "Quit", action: #selector(StatusItemController.quit(sender:)), keyEquivalent: "")
            menuItem.target = self
            statusItem.menu?.addItem(menuItem)
        }
    }

    @objc func quit(sender: Any) {
        NSApp.terminate(sender)
    }

    func updateList(list: Set<CacheItem>) {
        let dispatchGroup = DispatchGroup()
        for item in list {
            DispatchQueue.global().async {
                dispatchGroup.enter()
                var item = item
                item.size = item.locationSize
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                    if item.size! > 0 {
                        self.addMenuItem(cache: item)
                    }
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            print("Search complete")
            if self.isLoadingViewPresent {
                self.statusItem.menu?.removeItem(at: 0)
            }
        }
    }

    func updateSizes() {
        for item in list! {
            DispatchQueue.global().async {
                var item = item
                item.size = item.locationSize
                DispatchQueue.main.async {
                    if item.size! > 0 {
                        self.addMenuItem(cache: item)
                    }
                }
            }
        }
    }

    private func addMenuItem(cache: CacheItem) {
        assert(cache.size != nil)
        if let menuItem = statusItem.menu?.menuItem(for: cache) {
            //If menu is already present, update size
            print("Updating size of \(cache.name)")
            menuItem.cacheView?.update(size: cache.size!.bytesToReadableString)
        } else {
            //If menu is not present, create one and add
            print("Creating \(cache.name)")
            let cacheMenuItem = NSMenuItem(view: CacheMenuView.initialize(with: cache))
            cacheMenuItem.cacheView?.delegate = self
            let insertionIndex = self.isLoadingViewPresent ? 1 : 0
            statusItem.menu?.insertItem(cacheMenuItem, at: insertionIndex)
        }
    }
}

extension StatusItemController: CacheMenuViewDelegate {
    func itemRemoved(_ cacheId: String) {
        guard let cacheItem = list?.first(where: { $0.id == cacheId }) else {
            return
        }
        cacheItem.deleteCache()
        statusItem.menu?.removeCacheMenuItem(cacheId: cacheId)
    }
}
