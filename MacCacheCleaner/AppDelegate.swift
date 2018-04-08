//
//  AppDelegate.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 08/04/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Cocoa

var cacheItems: [CacheItem]!
typealias JSON = [String : Any]

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let url = URL(fileURLWithPath: "/Users/kaunteya/Downloads", isDirectory: true)
        _ = getSize(url)
    }
}

func updateCacheItems() {
    let url = Bundle.main.url(forResource: "Source", withExtension: "json")!
    let data = try! Data(contentsOf: url)
    let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [JSON]
    cacheItems = json.map { CacheItem($0) }
}
