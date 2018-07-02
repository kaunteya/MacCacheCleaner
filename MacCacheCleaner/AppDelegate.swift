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

//    var statusItemController = StatusItemController()

    var mainViewController: MainViewController!

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        let windowController = NSStoryboard.main?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "mainWindowController")) as! NSWindowController
        mainViewController = windowController.contentViewController as! MainViewController


//        startTimerForSizeRefresh(every: 60 * 60)
//
//        let mainListUpdateInterval: Double = (60 * 60 * 24) + (60 * 3) // 1 day + 3 min
//        startTimerForNetworkReload(every: mainListUpdateInterval)
    }

    private func startTimerForNetworkReload(every timeInterval: TimeInterval) {
        Timer.every(timeInterval) { [unowned self] _ in
            print("Updating from network")
            let githubURL = "https://raw.githubusercontent.com/kaunteya/MacCacheCleaner/master/Source.json"
//            self.statusItemController.updateMainListFromNetwork(urlString: githubURL)
        }.fire()
    }

    private func startTimerForSizeRefresh(every timeInterval: TimeInterval) {
        Timer.every(timeInterval) { [unowned self] _ in
            print("Updating size")
//            self.statusItemController.calculateSizeAndUpdateMenu(queue: .global(qos: .background))
        }
    }
}
