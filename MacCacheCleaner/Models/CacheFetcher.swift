//
//  CacheFetcher.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 02/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

typealias JSON = [String : Any]

struct CacheFetcher {
    let urlString: String

    func fromNetwork(
        completion: @escaping([CacheItem]) -> Void,
        failure: ((Error?) -> Void)?) {
        Log.info("Sending network request")
        var urlRequest = URLRequest(url: URL(string: urlString)!)
        urlRequest.timeoutInterval = 3
        URLSession.shared.dataTask(with: urlRequest) {
            (result: Result<JSON>) in
            switch result {
            case .success(let json):
                guard let items = json["items"] as? [JSON] else {
                    failure?(nil)
                    return
                }
                Log.info("Network response received")
                completion(items.map { CacheItem($0) })

            case .failure(let error): failure?(error)
            }
            }.resume()
    }
}
