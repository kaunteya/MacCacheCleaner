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
    let deleteActions: [String]?
    let deletePaths:[String]?
}

extension CacheItem {
    init(_ json: JSON) {
        id = json["id"] as! String
        name = json["name"] as! String
        imageURL = URL(string: json["image"] as! String)!

        description  = json["description"] as! String
        locations = (json["location"] as! [String]).map { Path(stringVal: $0)}
        let del = json["delete"] as! JSON
        deleteActions = del["actions"] as? [String]
        deletePaths = del["paths"] as? [String]
    }

    var locationSize: Int64 {
        var sizeBytes = 0 as Int64
        let urls = locations.map { $0.fileURL }

        urls.forEach { url in
            sizeBytes += FileManager.default.size(of: url)
        }
        return sizeBytes
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
