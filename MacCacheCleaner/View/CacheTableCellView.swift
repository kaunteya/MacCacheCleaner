//
//  CacheTableCellView.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 01/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit
//import SDWebImage

protocol CacheCellViewDelegate:class {
    func userActionClearCache(cacheId: CacheItem.ID, row: Int)
}

class CacheTableCellView: NSTableCellView {
    weak var delegate: CacheCellViewDelegate?
    @IBOutlet weak var deleteLoadingView: NSStackView!
    @IBOutlet weak var locationsStackView: NSStackView!

    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var sizeLabel: NSTextField!
    @IBOutlet weak var descriptionLabel: NSTextField!
    @IBOutlet weak var clearButton: NSButton!
//    @IBOutlet weak var cacheImageView: NSImageView!

    var id: CacheItem.ID!
    var rowIndex: Int!

    @IBAction func clearAction(_ sender: NSButton) {
        delegate?.userActionClearCache(cacheId: id, row: rowIndex)
    }

    func updateFor(cacheItem: CacheItem, size: CacheItem.FileSize, row: Int) {
        id = cacheItem.id
        rowIndex = row
        nameLabel.stringValue = cacheItem.name
        sizeLabel.stringValue = size.readable
        descriptionLabel.stringValue = cacheItem.description
        locationsStackView.arrangedSubviews.forEach(locationsStackView.removeView)

        cacheItem.locations.forEach { loc in
            let label = NSTextField(labelWithString: loc)
            label.font = NSFont.systemFont(ofSize: NSFont.smallSystemFontSize)
            label.textColor = NSColor.tertiaryLabelColor
            locationsStackView.addArrangedSubview(label)
        }

        clearButton.isHidden = false
        deleteLoadingView.isHidden = true
    }
    
    func showDeleteView() {
        clearButton.isHidden = true
        deleteLoadingView.isHidden = false
    }
}
