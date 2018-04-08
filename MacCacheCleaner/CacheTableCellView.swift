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

    private func updateSize(_ path: String) {
        let expandedPath = NSString(string: path).expandingTildeInPath
        let url = URL(fileURLWithPath: expandedPath, isDirectory: true)
        self.size.stringValue = "..."
        FileManager.default.size(of: url) { sizeBytes in
            DispatchQueue.main.async {
                let bfm = ByteCountFormatter()
                self.size.stringValue = bfm.string(fromByteCount: sizeBytes)
            }
        }
    }

    func update(for cache: CacheItem) {
        self.name.stringValue = cache.name
        self.cacheDescription.stringValue = cache.description
        updateSize(cache.location)
        let imageData = try! Data(contentsOf: cache.imageURL)
        self.image.image = NSImage(data: imageData)
    }
}
