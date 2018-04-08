//
//  CacheItem.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 08/04/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

struct CacheItem {
    let id: String
    let name: String
    let imageURL: URL
    let location: String
    let description: String

    init(_ json: JSON) {
        id = json["name"] as! String
        name = json["name"] as! String
        imageURL = URL(string: json["image"] as! String)!
        location = json["location"] as! String
        description  = json["description"] as! String
    }
}
