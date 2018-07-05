//
//  AppDelegate.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 08/04/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let cacheListFetcher = CacheFetcher(
        urlString: "https://raw.githubusercontent.com/kaunteya/MacCacheCleaner/master/Source.json"
    )

    let cacheList = CacheList()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let mainVC = MainViewController.initialize(cacheList: cacheList)
        NSWindowController.initialize( with: mainVC, sceneId: "mainWindowController")
            .showWindow(self)
        
        Timer.every(60) { _ in
            self.updateListFromNetwork()
        }.fire()
    }

    func updateListFromNetwork() {
        cacheListFetcher.fromNetwork(completion: { itemList in
            self.cacheList.list = itemList
        }, failure: nil)
    }
}
