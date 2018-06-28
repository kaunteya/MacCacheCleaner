//
//  InfoMenuView.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 27/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit
import ProgressKit

class LoadingMenuView: NSBox, NibLoadable {
    @IBOutlet weak var progressView: ShootingStars!

    static func initialize() -> LoadingMenuView {
        let view = LoadingMenuView.createFromNib()
        view.progressView.animate = true
        return view
    }
}
