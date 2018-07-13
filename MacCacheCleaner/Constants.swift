//
//  Constants.swift
//  Mac Cache Cleaner
//
//  Created by Kaunteya Suryawanshi on 12/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

extension URL {
    /// Fetches json which has details of all the cache definitions
    static let sourceJSONPath: URL = "https://raw.githubusercontent.com/kaunteya/MacCacheCleaner/master/Source.json"

//    static let sourceJSONPath: URL = "http://0.0.0.0:9111/Source.json"

    /// Fetches info of `latest` maccachecleaner from github
    static let latestVersion: URL = "https://api.github.com/repos/kaunteya/maccachecleaner/releases/latest"
}
