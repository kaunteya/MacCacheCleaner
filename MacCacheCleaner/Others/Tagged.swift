//
//  Tagged.swift
//  Mac Cache Cleaner
//
//  Created by Kaunteya Suryawanshi on 07/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

struct Tagged<Tag, RawValue> {
    let rawValue: RawValue
}

extension Tagged: Decodable where RawValue: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(rawValue: try container.decode(RawValue.self))
    }
}

extension Tagged: Equatable where RawValue: Equatable {
    static func ==(lhs: Tagged<Tag, RawValue>, rhs: Tagged<Tag, RawValue>) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

extension Tagged: Hashable where RawValue: Hashable {
    var hashValue: Int {
        return rawValue.hashValue
    }
}

extension Tagged: ExpressibleByIntegerLiteral where RawValue: ExpressibleByIntegerLiteral {
    typealias IntegerLiteralType = RawValue.IntegerLiteralType
    init(integerLiteral value: RawValue.IntegerLiteralType) {
        self.init(rawValue: RawValue(integerLiteral: value))
    }
}
