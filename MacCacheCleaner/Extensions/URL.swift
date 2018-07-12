//
//  URL.swift
//  Mac Cache Cleaner
//
//  Created by Kaunteya Suryawanshi on 12/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

extension URL : ExpressibleByStringLiteral {
    public typealias StringLiteralType = String

    public init(stringLiteral value: StringLiteralType) {
        self.init(string: value)!
    }
}
