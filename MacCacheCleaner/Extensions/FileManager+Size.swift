//
//  FileManager+Size.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 25/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

extension FileManager {

    func isDirectory(_ url: URL) -> Bool {
        var isDir : ObjCBool = false
        FileManager.default.fileExists(atPath: url.path, isDirectory: &isDir)
        return isDir.boolValue
    }

    func totalSize(of urls: [URL]) -> Int64 {
        var sizeBytes = 0 as Int64
        urls.forEach { url in
            sizeBytes += FileManager.default.size(of: url)
        }
        return sizeBytes
    }

    func size(of urls: [URL], completion: @escaping (Int64) -> Void) {
        var sizeBytes = 0 as Int64
        urls.forEach { url in
            DispatchQueue.global().async {
                sizeBytes += FileManager.default.size(of: url)
                completion(sizeBytes)
            }
        }
    }

    /// Calculates the size of directory
    ///
    /// - Parameter url: URL of the directory / file
    /// - Returns: Value in bytes
    func size(of url: URL) -> Int64 {
        if FileManager.default.isDirectory(url) {
            var totalSize: Int64 = 0

            let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: nil)!
            for a in enumerator {
                let f = a as! URL
                let gt = try! FileManager.default.attributesOfItem(atPath: f.path)
                let size = gt[FileAttributeKey.size] as! Int64
                totalSize += size
            }
            return totalSize
        } else {
            if let gt = try? FileManager.default.attributesOfItem(atPath: url.path) {
                return gt[FileAttributeKey.size] as! Int64
            }
            return 0
        }
    }
}
