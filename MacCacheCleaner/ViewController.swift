//
//  ViewController.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 08/04/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateCacheItems()
    }
}

extension ViewController: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return cacheItems.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "cacheCell"), owner: self) as! CacheTableCellView
        cell.update(for: cacheItems[row])

        return cell
    }

}
