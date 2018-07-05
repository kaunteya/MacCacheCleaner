//
//  CacheTableCellView.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 01/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

protocol CacheCellViewDelegate:class {
    func clear(cacheId: CacheItem.ID)
}

class CacheTableCellView: NSTableCellView {
    weak var delegate: CacheCellViewDelegate?

    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var sizeLabel: NSTextField!
    @IBOutlet weak var descriptionLabel: NSTextField!
    @IBOutlet weak var locationsLabel: NSTextField!

    var id: CacheItem.ID!

    @IBAction func clearAction(_ sender: NSButton) {
        delegate?.clear(cacheId: id)
    }

    func updateFor(cacheItem: CacheItem, size: CacheSize) {
        id = cacheItem.id
        nameLabel.stringValue = cacheItem.name
        sizeLabel.stringValue = size.readable
        descriptionLabel.stringValue = cacheItem.description
        locationsLabel.stringValue = cacheItem.files.locations
            .map { $0.stringVal }
            .joined(separator: "\n")
    }
}
