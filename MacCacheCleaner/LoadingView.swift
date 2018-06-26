//
//  LoadingView.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 26/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

class LoadingView: NSVisualEffectView {
    @IBOutlet weak var progressView: NSProgressIndicator!

    override func awakeFromNib() {
        super.awakeFromNib()
            progressView.startAnimation(nil)
    }
}
