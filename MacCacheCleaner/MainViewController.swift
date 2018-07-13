//
//  MainViewController.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 01/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

class MainViewController: NSViewController, StoryboardLoadable {

    @IBOutlet weak var loadingView: NSVisualEffectView!
    @IBOutlet var tableViewHandler: TableViewHandler!

    static var sceneIdentifier: String {
        return "mainVC"
    }
    static func initialize(cacheList: CacheList) -> MainViewController {
        let mainVC = makeFromStoryboard()
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
