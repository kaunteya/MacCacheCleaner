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
        self.statusItemController.updateMainListFromNetwork()
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) {
            [unowned self] _ in
            self.statusItemController.calculateSizeAndUpdateMenu(queue: .global(qos: .background))
        }
    }
}
