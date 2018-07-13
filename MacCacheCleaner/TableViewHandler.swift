//
//  TableDelegateDataSource.swift
//  Mac Cache Cleaner
//
//  Created by Kaunteya Suryawanshi on 10/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

protocol CacheTableViewDelegate: class {
    func cacheListUpdateStatusChanged(status: CacheList.UpdateStatus)
}

class TableViewHandler: NSObject {
    private let cacheCell = NSUserInterfaceItemIdentifier(rawValue: "cacheCell")
    var cacheList: CacheList!
    weak var delegate: CacheTableViewDelegate?

    @IBOutlet weak var tableView: NSTableView!

    func setCacheList(_ cacheList: CacheList) {
        self.cacheList = cacheList
        self.cacheList.delegate = self
    }
}

extension TableViewHandler: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return cacheList.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: cacheCell, owner: nil) as! CacheTableCellView
        let (itemId, size) = cacheList[row]
        let cacheItem = cacheList[itemId]!
        cell.updateFor(cacheItem: cacheItem, size: size, row: row)
        cell.delegate = self
        return cell
    }
}

extension TableViewHandler: CacheCellViewDelegate {
    func userActionClearCache(cacheId: CacheItem.ID, row: Int) {
        Log.info("Remove \(cacheList[cacheId]!.name)")
        let view = tableView.view(atColumn: 0, row: row, makeIfNecessary: false)
            as! CacheTableCellView
        view.showDeleteView()
        cacheList.delete(cacheId)
    }
}

extension TableViewHandler: CacheListDelegate {
    func cacheListUpdateStatusChanged(status: CacheList.UpdateStatus) {
        delegate?.cacheListUpdateStatusChanged(status: status)
    }

    func itemRemovedCompleted(item: CacheItem) {
        tableView.reloadData()
    }

    func gotSizeFor(item: CacheItem) {
        tableView.reloadData()
    }
}

