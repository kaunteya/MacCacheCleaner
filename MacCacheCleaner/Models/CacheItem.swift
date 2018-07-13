//
//  CacheItem.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 08/04/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

struct CacheItem: Decodable, Equatable {

    typealias ID = Tagged<CacheItem, String>
    typealias FileSize = Tagged<CacheItem, Int64>

    let id: ID
    let name: String
    let image: URL?
    let description: String
    let locations: [String]
}

extension CacheItem {
    private func locationToURL(str: String) -> URL {
        let expandedPath = NSString(string: str).expandingTildeInPath
        return URL(fileURLWithPath: expandedPath, isDirectory: true)
    }

    var size: FileSize {
        let sizeBytes = locations
            .map(locationToURL)
            .map(FileManager.sizeOf)
            .reduce(0 as Int64, +)
        return FileSize(integerLiteral: sizeBytes)
    }
    
    func delete(onComplete complete: (() -> Void)? = nil) {
        try? locations
            .map(locationToURL)
            .forEach(FileManager.remove)
        complete?()
    }
}

extension CacheItem: Hashable {
    var hashValue: Int {
        return id.hashValue
    }
}

extension Tagged where Tag == CacheItem, RawValue == Int64 {
    var readable: String {
        return ByteCountFormatter().string(fromByteCount: rawValue)
    }
}
