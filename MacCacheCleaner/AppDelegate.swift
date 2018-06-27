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
    let mainList = MainCache()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        mainList.updateFromNetwork {
            statusItemController.addNonZeroSizeItems(list: mainList.list!)
        }
    }
}
