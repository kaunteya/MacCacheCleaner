//
//  WindowControl.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 08/04/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    @IBAction func actionSortChanged(_ sender: NSPopUpButton) {
        print("Sort changed \(sender.indexOfSelectedItem)")
    }
}
