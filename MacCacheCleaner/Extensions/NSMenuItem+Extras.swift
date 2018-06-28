//
//  NSMenuItem+Extras.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 27/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

extension NSMenuItem {
    convenience init(view: NSView) {
        self.init()
        self.view = view
    }

    var cacheView: CacheMenuView? {
        return self.view as? CacheMenuView
    }
}
