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
    var cacheList: CacheList!

    class func initialize(cacheList: CacheList) -> MainViewController {
        let mainVC = NSStoryboard.main?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "mainVC")) as! MainViewController
        mainVC.cacheList = cacheList
        return mainVC
    }

    override func viewDidLoad() {
        cacheList.delegate = self
        cacheList.updateList()
    }

}

extension MainViewController: NSTableViewDelegate, NSTableViewDataSource {

    func numberOfRows(in tableView: NSTableView) -> Int {
        return cacheList.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "cacheCell"), owner: nil) as! CacheTableCellView
        let (item, size) = cacheList[cacheList.index(cacheList.startIndex, offsetBy: row)]
        cell.nameLabel.stringValue = item.name
        cell.sizeLabel.stringValue = size.readable
        cell.descriptionLabel.stringValue = item.description
        cell.locationsLabel.stringValue = item.files.locations.map { $0.stringVal }.joined(separator: "\n")
        return cell
    }
}

extension MainViewController: CacheListDelegate {
    func listUpdatedFromNetwork() {
        print("Delegate listUpdatedFromNetwork")
        cacheList.updateSize(queue: DispatchQueue.global(qos: .default))
    }

    func sizeUpdateStarted() {
        print("Delegate sizeUpdateStarted")
        //Show loading view
    }

    func gotSizeFor(item: CacheItem) {
        // Update table for item
        print("Delegate gotSizeFor \(item.name)")
        tableView.reloadData()
    }

    func sizeUpdateCompleted() {
        print("Delegate sizeUpdateCompleted")
        // Hide loading view
    }
}
