//
//  CacheItem.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 08/04/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

struct CacheItem: Decodable {

    typealias ID = Tagged<CacheItem, String>
    typealias FileSize = Tagged<CacheItem, Int64>

    let id: ID
    let name: String
    let image: URL?
    let description: String
    let locations: [Path]
}

extension CacheItem {
    func calculateSize() -> FileSize {
        var sizeBytes = 0 as Int64
        let urls = locations.map { $0.rawValue }
        
        urls.forEach { url in
            sizeBytes += FileManager.default.size(of: url)
        }
        return FileSize(integerLiteral: sizeBytes)
    }

    func delete(complete: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .utility).async {
            self.locations.forEach { path in
                Log.info("Removing \(path)")
                try? FileManager.default.removeItem(at: path.rawValue)
            }
            DispatchQueue.main.async {
                complete?()
            }
        }
    }
}

extension CacheItem: Hashable {
    var hashValue: Int {
        return id.hashValue
    }

    static func == (lhs: CacheItem, rhs: CacheItem) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Tagged where Tag == CacheItem, RawValue == Int64 {
    var readable: String {
        return ByteCountFormatter().string(fromByteCount: rawValue)
    }
}
