//
//  MainViewController.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 01/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

class MainViewController: NSViewController {

    @IBOutlet weak var loadingView: NSVisualEffectView!
    @IBOutlet var tableViewHandler: TableViewHandler!

    class func initialize(cacheList: CacheList) -> MainViewController {
        let mainVC = NSStoryboard.mainVC
        mainVC.tableViewHandler.setCacheList(cacheList)
        return mainVC
    }

    override func viewDidLoad() {
        tableViewHandler.delegate = self
    }
}

extension MainViewController: CacheTableViewDelegate {
    func cacheListUpdateStatusChanged(status: CacheList.UpdateStatus) {
        loadingView.isHidden = status == .completed
    }
}
