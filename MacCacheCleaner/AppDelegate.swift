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

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        timer = Timer.scheduledTimer(withTimeInterval: 1113, repeats: true) {
            [unowned self] _ in
            self.statusItemController.updateMainListFromNetwork()
        }
        timer.fire()
    }
}
