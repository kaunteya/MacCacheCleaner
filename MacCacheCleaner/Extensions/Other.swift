//
//  Other.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 27/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

extension Collection {
    // Maps elements to set after transformation
    func mapSet<T>(f: (Element) -> T) -> Set<T> where T: Hashable {
        let list = self.map { f($0) }
        return Set<T>(list)
    }
}
