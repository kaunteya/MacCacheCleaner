//
//  LoadingView.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 03/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

class LoadingView: NSVisualEffectView {
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    override func awakeFromNib() {
        progressIndicator.startAnimation(self)
    }
}
