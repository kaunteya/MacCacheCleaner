//
//  Other.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 08/04/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

extension FileManager {
    func isDirectory(_ url: URL) -> Bool {
        var isDir : ObjCBool = false
        FileManager.default.fileExists(atPath: url.path, isDirectory: &isDir)
        return isDir.boolValue
    }

    func getSize(_ url: URL) -> Int64 {

        guard FileManager.default.isDirectory(url) else {
            let gt = try! FileManager.default.attributesOfItem(atPath: url.path)
            return gt[FileAttributeKey.size] as! Int64
        }

        var totalSize: Int64 = 0
        let byteCountFormatter = ByteCountFormatter()

        let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: nil)!
        for a in enumerator {
            let f = a as! URL
            let gt = try! FileManager.default.attributesOfItem(atPath: f.path)
            let size = gt[FileAttributeKey.size] as! Int64
            totalSize += size
        }
        print(byteCountFormatter.string(fromByteCount: totalSize))

        return totalSize
    }
}
