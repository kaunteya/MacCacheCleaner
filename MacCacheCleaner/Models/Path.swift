//
//  Path.swift
//  Mac Cache Cleaner
//
//  Created by Kaunteya Suryawanshi on 07/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

struct Path: RawRepresentable, Hashable {
    var rawValue: URL
}

extension Path: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let str = try container.decode(String.self)
        let expandedPath = NSString(string: str).expandingTildeInPath
        self.rawValue = URL(fileURLWithPath: expandedPath, isDirectory: true)
    }
}

//extension Path: ExpressibleByStringLiteral {
//    typealias StringLiteralType = String
//    init(stringLiteral value: StringLiteralType) {
//        let expandedPath = NSString(string: value).expandingTildeInPath
//        self.rawValue = URL(fileURLWithPath: expandedPath, isDirectory: true)
//    }
//}
