//
//  ViewModel.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 26/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

protocol ListDelegate:class {
    func cacheItemInserted(at index: Int)
    func cacheItemLoadingComplete()
}

class ViewModel {

    var items = [CacheItem]()
    weak var delegate: ListDelegate?

    func fetch(completion: @escaping ([CacheItem]) -> Void) {
        let url = Bundle.main.url(forResource: "Source", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! JSON
        let items = json["items"] as! [JSON]
        let cacheItemList = items.map { CacheItem($0) }
        completion(cacheItemList)
    }

    func start() {
        self.fetch { itemList in
            let dispatchGroup = DispatchGroup()
            itemList.forEach { (item) in
                DispatchQueue.global().async {
                    dispatchGroup.enter()
                    var item = item
                    item.size = item.locationSize
                    DispatchQueue.main.async {
                        dispatchGroup.leave()
                        if item.size! > 0 {
                            self.items.append(item)
                            self.delegate?.cacheItemInserted(at: self.items.count - 1)
                        }
                    }
                }
            }
            dispatchGroup.notify(queue: .main) {
                self.delegate?.cacheItemLoadingComplete()
            }
        }
    }
}
