//
//  InfoMenuView.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 27/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

class LoadingMenuView: NSBox, NibLoadable {

    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    static func initialise() -> LoadingMenuView {
        let view = LoadingMenuView.createFromNib()
        view.progressIndicator.startAnimation(self)
        view.progressIndicator.usesThreadedAnimation = true
        return view
    }
}
