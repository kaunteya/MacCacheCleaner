//
//  NSWindowController+intialize.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 02/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

extension NSWindowController {
    class func initialize(with viewController: NSViewController, sceneId: String) -> NSWindowController {
        let windowController = NSStoryboard.main?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: sceneId)) as! NSWindowController
        windowController.contentViewController = viewController
        return windowController
    }
}
