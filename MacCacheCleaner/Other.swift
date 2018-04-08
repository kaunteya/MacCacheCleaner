//
//  Other.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 08/04/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

func run(command: [String]) {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = command
    task.launch()
//    task.waitUntilExit()
}


extension FileManager {
    func isDirectory(_ url: URL) -> Bool {
        var isDir : ObjCBool = false
        FileManager.default.fileExists(atPath: url.path, isDirectory: &isDir)
        return isDir.boolValue
    }

    func size(of url: URL, completion: @escaping (Int64) -> Void) {
        DispatchQueue.global().async {
            if FileManager.default.isDirectory(url) {
                var totalSize: Int64 = 0

                let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: nil)!
                for a in enumerator {
                    let f = a as! URL
                    let gt = try! FileManager.default.attributesOfItem(atPath: f.path)
                    let size = gt[FileAttributeKey.size] as! Int64
                    totalSize += size
                }
                completion(totalSize)
            } else {
                let gt = try! FileManager.default.attributesOfItem(atPath: url.path)
                completion(gt[FileAttributeKey.size] as! Int64)
            }
        }
    }
}
