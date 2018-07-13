//
//  AutoStartSpinner.swift
//  Mac Cache Cleaner
//
//  Created by Kaunteya Suryawanshi on 12/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

/// Upon setting spinner to AutoStartSpinner, they will start spinning immediately after loaded
class AutoStartSpinner: NSProgressIndicator {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.startAnimation(self)
    }
}
