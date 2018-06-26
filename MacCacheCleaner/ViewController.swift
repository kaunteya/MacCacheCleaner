//
//  ViewController.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 08/04/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    let viewModel = ViewModel()

    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var loadingView: LoadingView!

    override func viewDidLoad() {
        viewModel.delegate = self
        viewModel.start()
    }
}

extension ViewController: ListDelegate {
    func cacheItemRemoved(at index: Int) {
        tableView.reloadData()
    }

    func cacheItemInserted(at index: Int) {
        //TODO: Update only one cell
        tableView.reloadData()
    }

    func cacheItemLoadingComplete() {
        loadingView.removeFromSuperview()
    }
}

extension ViewController: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "cacheCell"), owner: self) as! CacheTableCellView
        cell.update(for: viewModel.items[row])

        return cell
    }
}
