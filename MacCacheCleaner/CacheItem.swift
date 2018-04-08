//
//  CacheItem.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 08/04/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation
/*
 "name": "Cocoapods",
 "image": "https://via.placeholder.com/150x150",
 "location": "~/Library/Caches/CocoaPods",
 "description": "CocoaPods is a dependency manager for Swift and Objective-C Cocoa projects.",
 "onClear": [
 {
 "type":"command",
 "action":"pod cache clear"
 }
 ]
*/
struct CacheItem {
    let name: String
    let imageURL: URL
    let location: String
    let description: String

    init(_ json: JSON) {
        name = json["name"] as! String
        imageURL = URL(string: json["image"] as! String)!
        location = json["location"] as! String
        description  = json["description"] as! String
    }
}
