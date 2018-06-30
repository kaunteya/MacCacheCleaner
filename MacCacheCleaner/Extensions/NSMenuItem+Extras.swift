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

    static var quit: NSMenuItem {
        return QuitMenuItem()
    }
}

fileprivate class QuitMenuItem: NSMenuItem {
    convenience init() {
        self.init(title: "Quit", action: #selector(QuitMenuItem.quit(sender:)), keyEquivalent: "")
        self.target = self
    }
    @objc func quit(sender: Any) {
        NSApp.terminate(sender)
    }
}
