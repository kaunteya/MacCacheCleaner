//
//  NibLoadable.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 27/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

// For views that can be loaded from nib file
protocol NibLoadable {
    // Name of the nib file
    static var nibName: String? { get }
    static func createFromNib(in bundle: Bundle) -> Self?
}

extension NibLoadable where Self: NSView {

    // Default nib name must be same as class name
    static var nibName: String? {
        return String(describing: Self.self)
    }

    static func createFromNib(in bundle: Bundle = Bundle.main) -> Self? {
        guard let nibName = nibName else { return nil }
        var topLevelArray: NSArray? = nil
        bundle.loadNibNamed(NSNib.Name(nibName), owner: self, topLevelObjects: &topLevelArray)
        guard let results = topLevelArray else { return nil }
        let views = Array<Any>(results).filter { $0 is Self }
        return views.last as? Self
    }
}
