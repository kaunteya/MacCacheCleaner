//
//  CacheItem.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 08/04/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

struct CacheItem: Decodable, Equatable {

    typealias ID = Tagged<CacheItem, String>

    let id: ID
    let name: String
    let image: URL?
    let description: String
    let locations: [Location]
}

extension CacheItem {
    func delete(onComplete complete: (() -> Void)? = nil) {
        locations.forEach{ try? $0.delete() }
        complete?()
    }
}

extension CacheItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
