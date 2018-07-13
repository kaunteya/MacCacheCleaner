//
//  URL.swift
//  Mac Cache Cleaner
//
//  Created by Kaunteya Suryawanshi on 12/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

// This would let us create URL directly from the string
// Eg. let url: URL = "http://abc.com"
// Note: Use this only when URL is local/hard coded. Dont use for URLs that can be in improper format
extension URL : ExpressibleByStringLiteral {
    public typealias StringLiteralType = String

    public init(stringLiteral value: StringLiteralType) {
        self.init(string: value)!
    }
}
