//
//  CacheTableCellView.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 08/04/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Cocoa
import SDWebImage

class CacheTableCellView: NSTableCellView {

    var cacheId: String!
    @IBOutlet weak var name: NSTextField!
    @IBOutlet weak var size: NSTextField!
    @IBOutlet weak var cacheDescription: NSTextField!
    @IBOutlet weak var location: NSTextField!
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
        self.cacheId = cache.id
        self.name.stringValue = cache.name
        self.location.stringValue = cache.location
        self.cacheDescription.stringValue = cache.description
        updateSize(cache.location)
        self.image.sd_setImage(with: cache.imageURL, completed: nil)
    }
}
