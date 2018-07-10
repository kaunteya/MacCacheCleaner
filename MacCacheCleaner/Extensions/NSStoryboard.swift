//
//  NSStoryboard.swift
//  Mac Cache Cleaner
//
//  Created by Kaunteya Suryawanshi on 10/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

extension NSStoryboard {
    static var mainVC: MainViewController {
        return NSStoryboard.main?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "mainVC")) as! MainViewController
    }
}
