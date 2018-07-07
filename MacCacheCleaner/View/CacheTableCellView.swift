//
//  CacheTableCellView.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 01/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit
import SDWebImage

protocol CacheCellViewDelegate:class {
    func userActionClearCache(cacheId: CacheItem.ID, row: Int)
}

class CacheTableCellView: NSTableCellView {
    weak var delegate: CacheCellViewDelegate?
    @IBOutlet weak var deleteLoadingView: NSStackView!

    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var sizeLabel: NSTextField!
    @IBOutlet weak var descriptionLabel: NSTextField!
    @IBOutlet weak var locationsLabel: NSTextField!
    @IBOutlet weak var clearButton: NSButton!
    @IBOutlet weak var cacheImageView: NSImageView!

    var id: CacheItem.ID!
    var rowIndex: Int!

    @IBAction func clearAction(_ sender: NSButton) {
        delegate?.userActionClearCache(cacheId: id, row: rowIndex)
    }

    func updateFor(cacheItem: CacheItem, size: CacheSize, row: Int) {
        id = cacheItem.id
        rowIndex = row
        nameLabel.stringValue = cacheItem.name
        sizeLabel.stringValue = size.readable
        descriptionLabel.stringValue = cacheItem.description
        locationsLabel.stringValue = cacheItem.files.locations
            .map { $0.stringVal }
            .joined(separator: "\n")
        if let url = cacheItem.imageURL {
//            cacheImageView.sd_setImage(with: url, completed: nil)
        }
        clearButton.isHidden = false
        deleteLoadingView.isHidden = true
    }
    
    func showDeleteView() {
        clearButton.isHidden = true
        deleteLoadingView.isHidden = false
    }
}
