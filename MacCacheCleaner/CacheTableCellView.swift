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
    @IBOutlet weak var size: NSTextField!
    @IBOutlet weak var cacheDescription: NSTextField!
    @IBOutlet weak var image: NSImageView!

    func getSize(at path: String) -> String {
        let expandedPath = NSString(string: path).expandingTildeInPath
        let url = URL(fileURLWithPath: expandedPath, isDirectory: true)
        let sizeBytes = FileManager.default.size(of: url)
        let bfm = ByteCountFormatter()
        return bfm.string(fromByteCount: sizeBytes)
    }

    func update(for cache: CacheItem) {
        self.name.stringValue = cache.name
        self.cacheDescription.stringValue = cache.description
        self.size.stringValue = getSize(at: cache.location)
    }
}
