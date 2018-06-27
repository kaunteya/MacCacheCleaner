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

    var statusItemController = StatusItemController()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        MainCache.updateFromNetwork { list in
            statusItemController.list = list
        }
    }
}
