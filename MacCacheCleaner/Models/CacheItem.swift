//
//  CacheItem.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 08/04/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

struct Path {
    let stringVal: String
    init(_ stringVal: String) {
        self.stringVal = stringVal
    }
    var fileURL: URL {
        let expandedPath = NSString(string: stringVal).expandingTildeInPath
        return URL(fileURLWithPath: expandedPath, isDirectory: true)
    }
}

struct CacheItem {
    let id: String
    let name: String
    let imageURL: URL
    var size: Int64?
    let description: String
    let locations: [Path]
}

extension CacheItem {
    init(_ json: JSON) {
        id = json["id"] as! String
        name = json["name"] as! String
        imageURL = URL(string: json["image"] as! String)!

        description  = json["description"] as! String
        locations = (json["location"] as! [String]).map { Path($0)}
    }

    private var locationSize: Int64 {
        var sizeBytes = 0 as Int64
        let urls = locations.map { $0.fileURL }

        urls.forEach { url in
            sizeBytes += FileManager.default.size(of: url)
        }
        return sizeBytes
    }

    func itemWithRelcalculatedSize() -> CacheItem {
        var item = self
        item.size = item.locationSize
        return item
    }

    func deleteCache(complete: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .utility).async {
            self.locations.forEach { path in
                print("Removing \(path)")
                try? FileManager.default.removeItem(at: path.fileURL)
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
