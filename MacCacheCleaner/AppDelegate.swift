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

    private let cacheListFetcher = CacheFetcher.init(url: .sourceJSONPath)

    private let cacheList = CacheList()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let mainVC = MainViewController.initialize(cacheList: cacheList)

        NSWindowController
            .makeWindowController(contentViewController: mainVC, sceneId: "mainWindowController")
            .showWindow(self)

        self.setCacheMainList()

        VersionHandler(githubURL: .latestVersion).showAlertForOldVersion()
    }

    private func setCacheMainList() {
        cacheListFetcher.fromNetwork(completion: { itemList in
            Log.info("Cache definitions fetch completed")
            self.cacheList.mainList = itemList
        }, failure: { error in
            if let error = error { NSAlert(error: error).runModal() }
            Log.info("Network failed \(error?.localizedDescription ?? "")")
        })
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
