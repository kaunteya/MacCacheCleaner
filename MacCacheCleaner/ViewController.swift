//
//  ViewController.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 08/04/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Cocoa

enum ListSortBy { case name, size }

class ViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!

    var sortedCacheList: [CacheItem]?
    var sort: ListSortBy = .name {
        didSet {
            tableView.reloadData()
        }
    }
    func updateSortedList(for sort: ListSortBy) {
//        switch sort {
//        case .name:
//            sortedCacheList = cacheItems.sorted(by: { (a, b) -> Bool in
//                a.name < b.name
//            })
//
//            case .size
//                sortedCacheList = cacheItems.sorted(by: { (a, b) -> Bool in
//                    a.name < b.si
//                })
//        }
    }
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
