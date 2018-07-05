//
//  Other.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 27/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

class AutoStartSpinner: NSProgressIndicator {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.startAnimation(self)
    }
}
