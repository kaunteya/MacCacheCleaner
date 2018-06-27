//
//  Other.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 27/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

extension NSMenuItem {
    convenience init(cache: CacheItem) {
        self.init()
        self.view = CacheMenuView.initialize(with: cache)
    }
}
