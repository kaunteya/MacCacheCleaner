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

    func update(for cache: CacheItem) {
        self.cacheId = cache.id
        self.name.stringValue = cache.name
        self.location.stringValue = cache.locations.map { $0.stringVal }.joined(separator: "\n")
        self.cacheDescription.stringValue = cache.description
        self.size.stringValue = cache.size?.bytesToReadableString ?? ""

        self.image.sd_setImage(with: cache.imageURL, completed: nil)
    }
}
