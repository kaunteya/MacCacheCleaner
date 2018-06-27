//
//  CacheView.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 27/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit
import SDWebImage

final class CacheView: MenuItemView, NibLoadable {

    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var sizeLabel: NSTextField!

    @IBOutlet weak var cacheImageField: NSImageView!
    @IBAction func clearTapped(_ sender: NSButton) {
        print("Clear tapped")
    }

    func configure(with cache: CacheItem) {
        nameLabel.stringValue = cache.name
        sizeLabel.stringValue = cache.size!.bytesToReadableString
        cacheImageField.sd_setImage(with: cache.imageURL, completed: nil)
    }
}
