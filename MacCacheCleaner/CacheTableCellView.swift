//
//  CacheTableCellView.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 01/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

protocol CacheViewDelegate:class {
    func clear(cacheId: CacheID)
}

class CacheTableCellView: NSTableCellView {
    weak var delegate: CacheViewDelegate?

    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var sizeLabel: NSTextField!
    @IBOutlet weak var descriptionLabel: NSTextField!
    @IBOutlet weak var locationsLabel: NSTextField!

    var id: CacheID!

    @IBAction func clearAction(_ sender: NSButton) {
        delegate?.clear(cacheId: id)
    }
}
