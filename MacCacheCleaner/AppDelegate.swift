//
//  AppDelegate.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 08/04/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Cocoa
let sourceJSONPath: URL = "https://raw.githubusercontent.com/kaunteya/MacCacheCleaner/master/Source.json"
let latestVersion: URL = "https://api.github.com/repos/kaunteya/maccachecleaner/releases/latest"

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let cacheListFetcher = CacheFetcher.init(url: sourceJSONPath)

    let cacheList = CacheList()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let mainVC = MainViewController.initialize(cacheList: cacheList)
        NSWindowController.initialize( with: mainVC, sceneId: "mainWindowController")
            .showWindow(self)
        
        self.updateListFromNetwork()

        VersionHandler(githubURL: latestVersion).showAlertForOldVersion()
    }

    func updateListFromNetwork() {
        cacheListFetcher.fromNetwork(completion: { itemList in
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
