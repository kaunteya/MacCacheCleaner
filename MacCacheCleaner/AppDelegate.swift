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

    var timer: Timer!
    var statusItemController = StatusItemController()
    let githubURL = "https://raw.githubusercontent.com/kaunteya/MacCacheCleaner/master/Source.json"

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        timer = Timer.scheduledTimer(withTimeInterval: 1113, repeats: true) { _ in
            MainCache.getFromNetwork(urlString: self.githubURL) {
                [unowned self] list in
                self.statusItemController.list = list
            }
        }
        timer.fire()
    }
}
