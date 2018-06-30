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
    let loadingMenuItem = NSMenuItem(view: LoadingMenuView.initialise())

    var list: Set<CacheItem>? {
        didSet {
            if list != nil {
                let qos: DispatchQoS.QoSClass = oldValue == nil ? .userInitiated : .background
                self.updateList(
                    list: list!,
                    queue: .global(qos: qos))
            }
        }
    }

    var timer: Timer!

    init() {
        statusItem = NSStatusBar.system.statusItem(withLength: -1)
        statusItem.button?.image = #imageLiteral(resourceName: "StatusIcon")
        statusItem.menu = NSMenu()
        addDefaultMenuItems()
    }

    func updateMainListFromNetwork() {
        let githubURL = "https://raw.githubusercontent.com/kaunteya/MacCacheCleaner/master/Source.json"
        MainCache.getFromNetwork(urlString: githubURL) {
            [unowned self] list in
            self.list = list
        }
    }

    var isLoadingViewVisible: Bool {
        return statusItem.menu?.item(at: 0)?.view is LoadingMenuView
    }

    func addDefaultMenuItems() {
        // Loading View
        statusItem.menu?.addItem(loadingMenuItem)

        statusItem.menu?.addItem(.separator())

        // Quit
        let menuItem = NSMenuItem(title: "Quit", action: #selector(StatusItemController.quit(sender:)), keyEquivalent: "")
        menuItem.target = self
        statusItem.menu?.addItem(menuItem)
    }

    @objc func quit(sender: Any) {
        NSApp.terminate(sender)
    }

    func updateList(list: Set<CacheItem>, queue: DispatchQueue) {
        let dispatchGroup = DispatchGroup()
        for item in list {
            queue.async {
                dispatchGroup.enter()
                var item = item
                item.size = item.locationSize
                DispatchQueue.main.async {[weak self] in
                    dispatchGroup.leave()
                    if item.size! > 0 {
                        self?.addMenuItem(cache: item)
                    }
                }
            }
        }
        dispatchGroup.notify(queue: .main) {[unowned self] in
            if self.isLoadingViewVisible {
                self.statusItem.menu?.removeItem((self.loadingMenuItem))
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
            let cacheMenuItem = NSMenuItem(view: CacheMenuView.initialize(with: cache))
            cacheMenuItem.cacheView?.delegate = self
            let insertionIndex = self.isLoadingViewVisible ? 1 : 0
            print("Creating \(cache.name) at \(insertionIndex)")

            statusItem.menu?.insertItem(cacheMenuItem, at: insertionIndex)
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
