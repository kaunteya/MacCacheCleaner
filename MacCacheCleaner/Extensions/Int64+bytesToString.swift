//
//  Int64+bytesToString.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 25/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

extension Int64 {
    var bytesToReadableString: String {
        let bfm = ByteCountFormatter()
        return bfm.string(fromByteCount: self)
    }
}
