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
    typealias ID = String

    let id: String
    let name: String
    let imageURL: URL?
    let description: String
    let files: Files
}


extension CacheItem {
    init(_ json: JSON) {
        id = json["id"] as! ID
        name = json["name"] as! String
        imageURL = (json["image"] as? String).flatMap { URL(string: $0) }

        description  = json["description"] as! String
        let locations = (json["location"] as! [String]).map { Path($0)}
        files = Files(locations: locations)
    }
    
    struct Files {
        let locations: [Path]

        func calculateSize() -> CacheSize {
            var sizeBytes = 0 as Int64
            let urls = locations.map { $0.fileURL }

            urls.forEach { url in
                sizeBytes += FileManager.default.size(of: url)
            }
            return CacheSize(bytes: sizeBytes)
        }

        func delete(complete: (() -> Void)? = nil) {
            DispatchQueue.global(qos: .utility).async {
                self.locations.forEach { path in
                    Log.info("Removing \(path)")
                    try? FileManager.default.removeItem(at: path.fileURL)
                }
                DispatchQueue.main.async {
                    complete?()
                }
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
