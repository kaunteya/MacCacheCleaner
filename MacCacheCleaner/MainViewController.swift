//
//  MainViewController.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 01/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

class MainViewController: NSViewController {
    
    var cacheList: CacheList!

    @IBOutlet weak var loadingView: NSVisualEffectView!
    @IBOutlet var tableViewHandler: TableViewHandler!

    class func initialize(cacheList: CacheList) -> MainViewController {
        let mainVC = NSStoryboard.mainVC
        mainVC.cacheList = cacheList
        return mainVC
    }

    override func viewDidLoad() {
        cacheList.delegate = self
        tableViewHandler.cacheList = cacheList
    }
}

extension MainViewController: CacheListDelegate {
    func itemRemovedCompleted(item: CacheItem) {
        tableViewHandler.reloadTable()
    }

    func sizeUpdateStarted() {
        loadingView.isHidden = false
    }

    func gotSizeFor(item: CacheItem) {
        Log.info("Delegate gotSizeFor \(item.name)")
        tableViewHandler.reloadTable()
    }

    func sizeUpdateCompleted() {
        loadingView.isHidden = true
    }
}
