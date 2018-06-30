//
//  URLSession+Result.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 30/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error?)
}


extension URLSession {
    func dataTask(with request: URLRequest,
                  completion: @escaping (Result<JSON>) -> Void
        ) -> URLSessionDataTask {

        return self.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let data = data, let _ = response else {
                completion(.failure(nil))
                return
            }
            guard let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let json = jsonObj as? JSON
                else {
                    completion(.failure(nil))
                    return
            }

            completion(.success(json))
        }
    }
}
