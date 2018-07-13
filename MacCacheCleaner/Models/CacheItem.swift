//
//  CacheItem.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 08/04/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

struct Location: RawRepresentable, Hashable {
    typealias RawValue = URL
    typealias Size = Tagged<Location, Int64>
    typealias SizeMap = [Location: Location.Size]

    var rawValue: RawValue
    var size: Size {
        let size = FileManager.sizeOf(rawValue)
        return Size(integerLiteral: size)
    }
    func delete() throws {
        try FileManager.remove(rawValue)
    }
}

extension Location: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let str = try container.decode(String.self)
        let expandedPath = NSString(string: str).expandingTildeInPath
        self.rawValue = URL(fileURLWithPath: expandedPath, isDirectory: true)
    }
}

struct CacheItem: Decodable, Equatable {

    typealias ID = Tagged<CacheItem, String>

    let id: ID
    let name: String
    let image: URL?
    let description: String
    let locations: [Location]
}

extension Dictionary where Key == Location, Value == Location.Size {
    var totalSize: Location.Size {
        let totalSize = values
            .map { $0.rawValue}
            .reduce(0, +)
        return Location.Size(rawValue: totalSize)
    }
}

extension Array where Element == Location {
    var sizeMap: Location.SizeMap {
        var dict = Location.SizeMap()
        forEach { location in
            dict[location] = location.size
        }
        return dict
    }
}

extension CacheItem {

    func delete(onComplete complete: (() -> Void)? = nil) {
        locations.forEach{ try? $0.delete() }
        complete?()
    }
}

extension CacheItem: Hashable {
    var hashValue: Int {
        return id.hashValue
    }
}

extension Tagged where Tag == Location, RawValue == Int64 {
    var readable: String {
        return ByteCountFormatter().string(fromByteCount: rawValue)
    }
}
