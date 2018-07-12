//
//  AppDelegate.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 08/04/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Cocoa
let sourceJSONPath = "https://raw.githubusercontent.com/kaunteya/MacCacheCleaner/master/Source.json"

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let cacheListFetcher = CacheFetcher(urlString: sourceJSONPath)

    let cacheList = CacheList()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let mainVC = MainViewController.initialize(cacheList: cacheList)
        NSWindowController.initialize( with: mainVC, sceneId: "mainWindowController")
            .showWindow(self)
        
        self.updateListFromNetwork()
    }

    func updateListFromNetwork() {
        cacheListFetcher.fromNetwork(completion: { itemList in
            self.cacheList.mainList = itemList
        }, failure: { error in
            Log.info("Network failed \(error?.localizedDescription ?? "")")
        })
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
