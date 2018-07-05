//
//  MainViewController.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 01/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

class MainViewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var loadingView: NSVisualEffectView!

    var cacheList: CacheList!

    class func initialize(cacheList: CacheList) -> MainViewController {
        let mainVC = NSStoryboard.main?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "mainVC")) as! MainViewController
        mainVC.cacheList = cacheList
        return mainVC
    }

    override func viewDidLoad() {
        cacheList.delegate = self
    }
}

extension MainViewController: NSTableViewDelegate, NSTableViewDataSource {

    func numberOfRows(in tableView: NSTableView) -> Int {
        return cacheList.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "cacheCell"), owner: nil) as! CacheTableCellView
        let (itemId, size) = cacheList[row]
        let cacheItem = cacheList[itemId]!
        cell.updateFor(cacheItem: cacheItem, size: size, row: row)
        cell.delegate = self
        return cell
    }
}

extension MainViewController: CacheCellViewDelegate {
    func userActionClearCache(cacheId: CacheItem.ID, row: Int) {
        Log.info("Remove \(cacheList[cacheId]!.name)")
        let view = tableView.view(atColumn: 0, row: row, makeIfNecessary: false)
            as! CacheTableCellView
        view.showDeleteView()
        cacheList.delete(cacheId)
    }
}

extension MainViewController: CacheListDelegate {
    func itemRemovedCompleted(item: CacheItem) {
        tableView.reloadData()
    }

    func sizeUpdateStarted() {
        loadingView.isHidden = false
    }

    func gotSizeFor(item: CacheItem) {
        // Update table for item
        Log.info("Delegate gotSizeFor \(item.name)")
        tableView.reloadData()
    }

    func sizeUpdateCompleted() {
        loadingView.isHidden = true
    }
}
