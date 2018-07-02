//
//  CacheList.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 02/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

protocol CacheListDelegate: class {
    func sizeUpdateStarted()
    func gotSizeFor(item: CacheItem)
    func sizeUpdateCompleted()
    func listUpdatedFromNetwork()
}

class CacheList {
    var list = [CacheItem]()
    var sizes = DictionaryType()
    private let cacheListFetcher: CacheListFetcher

    init(_ fetcher: CacheListFetcher, reloadTime: TimeInterval) {
        self.cacheListFetcher = fetcher
    }

    weak var delegate: CacheListDelegate?

    var cacheSizeList: [(CacheItem, CacheSize)] {
        var arr = [(CacheItem, CacheSize)]()
        for k in sizes.keys {
            arr.append((k, sizes[k]!))
        }
        return arr
    }
}

extension CacheList {
    func updateList() {
        cacheListFetcher.fromNetwork(completion: { itemList in
            self.list = itemList
            self.delegate?.listUpdatedFromNetwork()
        }, failure: nil)
    }


    func updateSize(queue: DispatchQueue) {
        delegate?.sizeUpdateStarted()
        let dispatchGroup = DispatchGroup()
        list.forEach { item in
            queue.async {
                dispatchGroup.enter()
                let size = item.files.calculateSize()
                DispatchQueue.main.async { [unowned self] in
                    dispatchGroup.leave()
                    self.sizes[item] = size
                    self.delegate?.gotSizeFor(item: item)
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.delegate?.sizeUpdateCompleted()
        }
    }
}

extension CacheList: Collection {
    subscript(position: CacheList.DictionaryType.Index) -> (key: CacheItem, value: CacheSize) {
        return sizes[position]
    }

    typealias DictionaryType = [CacheItem: CacheSize]
    typealias Index = DictionaryType.Index
    typealias Element = DictionaryType.Element


    subscript(position: CacheItem) -> CacheSize {
        return sizes[position]!
    }

    var startIndex: Index {
        return sizes.startIndex
    }

    var endIndex: Index {
        return sizes.endIndex
    }

    func index(after i: Index) -> Index {
        return sizes.index(after: i)
    }
}
