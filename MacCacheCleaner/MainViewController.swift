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
    let list = [
        CacheItem.makeMock(name: "Brew", pathCount: 3),
        CacheItem.makeMock(name: "Chrome", pathCount: 2),
        CacheItem.makeMock(name: "Firefox", pathCount: 7)
    ]

}

extension MainViewController: NSTableViewDelegate, NSTableViewDataSource {

    func numberOfRows(in tableView: NSTableView) -> Int {
        return list.count
    }
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "cacheCell"), owner: nil) as! CacheTableCellView
        let a = list[row]
        cell.nameLabel.stringValue = a.name
        cell.descriptionLabel.stringValue = a.description
        cell.locationsLabel.stringValue = a.files.locations.map { $0.stringVal }.joined(separator: "\n")
        return cell
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        print("Selected \(tableView.selectedRow)")
        let view = tableView.view(atColumn: 0, row: tableView.selectedRow, makeIfNecessary: false) as! CacheTableCellView
    }
}
