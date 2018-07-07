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
    func itemRemovedCompleted(item: CacheItem)
}

class CacheList {
    typealias ItemAndSize = (id: CacheItem.ID, size: CacheSize)

    private var listWithSizes = [ItemAndSize]()

    /// List info loaded from Internet
    /// Can be updated only from URL response
    var mainList: [CacheItem]? {
        didSet {
            let qos: DispatchQoS.QoSClass = mainList == nil ? .default : .utility
            updateSize(queue: DispatchQueue.global(qos: qos))
        }
    }

    weak var delegate: CacheListDelegate?

    subscript(id: CacheItem.ID) -> CacheItem? {
        let item = mainList?.first(where: { $0.id == id })
        return item
    }
}

extension CacheList {

    func updateSize(queue: DispatchQueue) {
        delegate?.sizeUpdateStarted()
        let dispatchGroup = DispatchGroup()
        mainList?.forEach { item in
            queue.async {
                dispatchGroup.enter()
                let size = item.calculateSize()
                DispatchQueue.main.async { [unowned self] in
                    dispatchGroup.leave()
                    if size.bytes > 0 {
                        self.updateListWithSizes(element: ItemAndSize(id: item.id, size: size))
                        self.delegate?.gotSizeFor(item: item)
                    }
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.delegate?.sizeUpdateCompleted()
        }
    }

    private func updateListWithSizes(element: ItemAndSize) {
        if let index = listWithSizes.index(where: { $0.id == element.id}) {
            listWithSizes[index] = element
        } else {
            listWithSizes.append(element)
        }
        listWithSizes.sort { $0.size.bytes > $1.size.bytes }
    }

    func delete(_ id: CacheItem.ID) {
        let cacheItem = self[id]!
        cacheItem.delete { [unowned self] in
            self.listWithSizes = self.listWithSizes.filter { $0.id != id }
            self.delegate?.itemRemovedCompleted(item: cacheItem)
        }
    }
}

extension CacheList: Collection {
    typealias Index = Int
    typealias Element = ItemAndSize

    subscript(position: Int) -> ItemAndSize {
        return listWithSizes[position]
    }

    func index(after i: Int) -> Int {
        return listWithSizes.index(after: i)
    }

    var startIndex: CacheList.Index {
        return listWithSizes.startIndex
    }
    var endIndex: CacheList.Index {
        return listWithSizes.endIndex
    }
}
