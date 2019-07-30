//
//  CacheList.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 02/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

protocol CacheListDelegate: class {
    func gotSizeFor(item: CacheItem)
    func itemRemovedCompleted(item: CacheItem)
    func cacheListUpdateStatusChanged(status: CacheList.UpdateStatus)
}

class CacheList {
    typealias ItemAndSize = (id: CacheItem.ID, totalSize: Location.Size, sizeMap: Location.SizeMap)
    enum UpdateStatus { case started, completed, failed }

    private var listWithSizes = [ItemAndSize]()

    /// List info loaded from Internet
    /// Can be updated only from URL response
    var mainList: [CacheItem]? {
        didSet {
            let qos: DispatchQoS.QoSClass = mainList == nil ? .default : .utility
            updateSize(queue: .global(qos: qos))
        }
    }

    weak var delegate: CacheListDelegate?

    subscript(id: CacheItem.ID) -> CacheItem? {
        return mainList?.first(where: { $0.id == id })
    }
}

extension CacheList {

    func updateSize(queue: DispatchQueue) {
        guard let mainList = mainList else {
            delegate?.cacheListUpdateStatusChanged(status: .failed)
            return
        }
        delegate?.cacheListUpdateStatusChanged(status: .started)

        let dispatchGroup = DispatchGroup()
        mainList.forEach { item in
            queue.async {
                dispatchGroup.enter()
                let sizeMap = item.locations.sizeMap
                let totalSize = sizeMap.totalSize

                DispatchQueue.main.async { [unowned self] in
                    dispatchGroup.leave()
                    if totalSize.rawValue > 0 {
                        let itemSize = ItemAndSize(id: item.id, totalSize: totalSize, sizeMap: sizeMap)
                        self.updateListWithSizes(element: itemSize)
                        self.delegate?.gotSizeFor(item: item)
                    }
                }
            }
        }
        dispatchGroup.notify(queue: .main) { [unowned self] in
            self.delegate?.cacheListUpdateStatusChanged(status: .completed)
        }
    }

    private func updateListWithSizes(element: ItemAndSize) {
        if let index = listWithSizes.firstIndex(where: { $0.id == element.id}) {
            listWithSizes[index] = element
        } else {
            listWithSizes.append(element)
        }
        listWithSizes.sort { $0.totalSize.rawValue > $1.totalSize.rawValue }
    }

    func delete(_ id: CacheItem.ID) {
        let cacheItem = self[id]!
        // Delete on background queue and call completion on main queue
        DispatchQueue.global(qos: .utility).async {
            cacheItem.delete(onComplete: {
                DispatchQueue.main.async {
                    self.listWithSizes = self.listWithSizes.filter { $0.id != id }
                    self.delegate?.itemRemovedCompleted(item: cacheItem)
                }
            })
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
