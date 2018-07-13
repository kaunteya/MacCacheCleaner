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
    func userActionClearLocation(cacheId: CacheItem.ID, location: String, row: Int)
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

    func updateFor(cacheItem: CacheItem, totalSize: Location.Size, sizeMap: Location.SizeMap, row: Int) {
        id = cacheItem.id
        rowIndex = row
        nameLabel.stringValue = cacheItem.name
        sizeLabel.stringValue = totalSize.readable
        descriptionLabel.stringValue = cacheItem.description

        locationsStackView.removeAllArrangedSubViews()
        cacheItem.locations
            .map {location in
                let readableSize = sizeMap[location]!.readable
                return LocationView(location.rawValue.relativePath, size: readableSize, onDelete: { }) }
            .forEach(locationsStackView.addArrangedSubview)

        clearButton.isHidden = false
        deleteLoadingView.isHidden = true
    }

    func showDeleteView() {
        clearButton.isHidden = true
        deleteLoadingView.isHidden = false
    }
}

class LocationView: NSStackView {
    let onDelete: () -> Void
    let strValue: String
    init(_ location: String, size: String, onDelete: @escaping () -> Void) {
        self.strValue = location
        self.onDelete = onDelete
        super.init(frame: .zero)
        let button = NSButton(image: NSImage(named: .touchBarDeleteTemplate)!, target: self, action: #selector(deleteAction))
        button.isBordered = false
        button.bezelStyle = .roundRect
        self.addArrangedSubview(LocationLabel(location))
        self.addArrangedSubview(LocationLabel(size))
        self.addArrangedSubview(button)
        self.orientation = .horizontal
        self.spacing = 2
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func deleteAction() {
        print("Delete \(strValue)")
    }
}

fileprivate class LocationLabel: NSTextField {
    convenience init(_ str: String) {
        self.init(labelWithString: str)
        self.font = NSFont.systemFont(ofSize: NSFont.smallSystemFontSize)
        self.textColor = NSColor.tertiaryLabelColor
    }
}
