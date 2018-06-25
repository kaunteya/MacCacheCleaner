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

    var items = [CacheItem]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    func getCacheItems() -> [CacheItem] {
        let url = Bundle.main.url(forResource: "Source", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! JSON
        let items = json["items"] as! [JSON]
        return items.map { CacheItem($0) }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        let allCacheItems = getCacheItems()

        allCacheItems.forEach { item in
            var item = item
            item.getSizeOfLocations { (size) in
                guard size > 0 else { return }
                item.size = size
                self.items.append(item)
                print("Adding \(item.name)")
            }
        }
    }
}

extension ViewController: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "cacheCell"), owner: self) as! CacheTableCellView
        cell.update(for: items[row])

        return cell
    }

}
