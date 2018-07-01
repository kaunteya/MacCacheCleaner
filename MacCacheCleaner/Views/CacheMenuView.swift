//
//  CacheView.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 27/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit
//import SDWebImage

protocol CacheMenuViewDelegate:class {
    func itemRemoved(_ cacheId: String)
}

class CacheMenuView: NSBox, NibLoadable {

    @IBOutlet weak var mainStackView: NSStackView!
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var sizeLabel: NSTextField!
    @IBOutlet weak var deleteButton: NSButton!
    @IBOutlet weak var cacheImageField: NSImageView?

    lazy var progressIndicator: NSProgressIndicator = {
        let pr = NSProgressIndicator()
        pr.controlSize = .small
        pr.style = NSProgressIndicator.Style.spinning
        return pr
    }()

    var cacheId: String!
    weak var delegate: CacheMenuViewDelegate?

    @IBAction func clearTapped(_ sender: NSButton) {
        showProgressOnDelete()
        delegate?.itemRemoved(cacheId)
    }

    static func initialize(with cache: CacheItem, size: CacheSize) -> CacheMenuView {
        let cacheView = CacheMenuView.createFromNib()
        cacheView.cacheId = cache.id
        cacheView.nameLabel.stringValue = cache.name
        cacheView.sizeLabel.stringValue = size.readable
//        cacheView.cacheImageField?.sd_setImage(with: cache.imageURL, completed: nil)
        return cacheView
    }

    private func showProgressOnDelete() {
        mainStackView.addArrangedSubview(progressIndicator)
        progressIndicator.startAnimation(self)
        mainStackView.removeArrangedSubview(deleteButton)
        deleteButton.removeFromSuperview()
    }

    func update(size: String) {
        sizeLabel.stringValue = size
    }
}
