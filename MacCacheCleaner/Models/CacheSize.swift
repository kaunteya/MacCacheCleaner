//
//  CacheSize.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 01/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

struct CacheSize: Hashable {
    let bytes: Int64

    var readable: String {
        return ByteCountFormatter().string(fromByteCount: bytes)
    }
}
