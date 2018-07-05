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
    @IBOutlet weak var loadingView: LoadingView!

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
        cell.nameLabel.stringValue = cacheItem.name
        cell.sizeLabel.stringValue = size.readable
        cell.descriptionLabel.stringValue = cacheItem.description
        cell.locationsLabel.stringValue = cacheItem.files.locations.map { $0.stringVal }.joined(separator: "\n")
        return cell
    }
}

extension MainViewController: CacheListDelegate {

    func sizeUpdateStarted() {
        loadingView.isHidden = false
    }

    func gotSizeFor(item: CacheItem) {
        // Update table for item
        print("Delegate gotSizeFor \(item.name)")
        tableView.reloadData()
    }

    func sizeUpdateCompleted() {
        loadingView.isHidden = true
    }
}
