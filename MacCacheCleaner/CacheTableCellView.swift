//
//  CacheTableCellView.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 08/04/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Cocoa

class CacheTableCellView: NSTableCellView {

    @IBOutlet weak var name: NSTextField!
    @IBOutlet weak var cacheDescription: NSTextField!
    @IBOutlet weak var image: NSImageView!

    func update(for cache: CacheItem) {
        self.name.stringValue = cache.name
        self.cacheDescription.stringValue = cache.description
    }
}
