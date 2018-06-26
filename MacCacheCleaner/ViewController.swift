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
    let viewModel = ViewModel()

    override func viewDidLoad() {
        viewModel.delegate = self
        viewModel.start()
    }
}

extension ViewController: ListDelegate {
    func cacheItemInserted(at index: Int) {
        //TODO: Update only one cell
        tableView.reloadData()
    }

    func cacheItemLoadingComplete() {

    }
}

extension ViewController: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int {
        print("Count \(viewModel.items.count)")
        return viewModel.items.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "cacheCell"), owner: self) as! CacheTableCellView
        cell.update(for: viewModel.items[row])

        return cell
    }
}
