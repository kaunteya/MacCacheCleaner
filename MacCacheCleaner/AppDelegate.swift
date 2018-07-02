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

    var mainViewController: MainViewController!

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        let urlString = "https://raw.githubusercontent.com/kaunteya/MacCacheCleaner/master/Source.json"

        NSWindowController.initialize(
            with: MainViewController.initialize(
                cacheList: CacheList(
                    CacheListFetcher(urlString: urlString),
                    reloadTime: 60
                )
            ),
            sceneId: "mainWindowController")
        .showWindow(self)
    }
}
