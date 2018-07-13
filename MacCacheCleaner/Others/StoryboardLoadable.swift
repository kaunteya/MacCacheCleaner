//
//  StoryboardLoadable.swift
//  Mac Cache Cleaner
//
//  Created by Kaunteya Suryawanshi on 13/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

/// Lets NSViewController subclass be created from Storyboard
protocol StoryboardLoadable {
    static var storyboard: NSStoryboard {get}
    static var sceneIdentifier: String {get}
    static func makeFromStoryboard() -> Self
}

extension StoryboardLoadable {
    static var storyboard: NSStoryboard {
        return NSStoryboard.main!
    }

    static func makeFromStoryboard() -> Self {
        let sceneID = NSStoryboard.SceneIdentifier(rawValue:sceneIdentifier)
        return storyboard.instantiateController(withIdentifier: sceneID) as! Self
    }
}
