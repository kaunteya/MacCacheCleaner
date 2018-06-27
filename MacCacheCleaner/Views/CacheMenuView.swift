//
//  CacheView.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 27/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit
import SDWebImage

protocol CacheMenuViewDelegate:class {
    func itemRemoved(_ cacheId: String)
}

class CacheMenuView: NSBox, NibLoadable {

    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var sizeLabel: NSTextField!

    @IBOutlet weak var cacheImageField: NSImageView?
    var cacheId: String!
    weak var delegate: CacheMenuViewDelegate?

    @IBAction func clearTapped(_ sender: NSButton) {
        delegate?.itemRemoved(cacheId)
    }

    static func initialize(with cache: CacheItem) -> CacheMenuView {
        let cacheView = CacheMenuView.createFromNib()!
        cacheView.cacheId = cache.id
        cacheView.nameLabel.stringValue = cache.name
        cacheView.sizeLabel.stringValue = cache.size!.bytesToReadableString
        cacheView.cacheImageField?.sd_setImage(with: cache.imageURL, completed: nil)
        return cacheView
    }
}
