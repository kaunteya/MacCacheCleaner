//
//  TableDelegateDataSource.swift
//  Mac Cache Cleaner
//
//  Created by Kaunteya Suryawanshi on 10/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

class TableViewHandler: NSObject {
    weak var cacheList: CacheList!
    @IBOutlet weak var tableView: NSTableView!

    func reloadTable() {
        tableView.reloadData()
    }
}

extension TableViewHandler: NSTableViewDelegate, NSTableViewDataSource {
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

extension TableViewHandler: CacheCellViewDelegate {
    func userActionClearCache(cacheId: CacheItem.ID, row: Int) {
        Log.info("Remove \(cacheList[cacheId]!.name)")
        let view = tableView.view(atColumn: 0, row: row, makeIfNecessary: false)
            as! CacheTableCellView
        view.showDeleteView()
        cacheList.delete(cacheId)
    }
}
