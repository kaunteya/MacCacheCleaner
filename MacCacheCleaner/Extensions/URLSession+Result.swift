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

    func jsonDecodableTask<T: Decodable>(
        with url: URL,
        completion: @escaping (Result<T>) -> Void
        ) -> URLSessionDataTask {

        return self.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let data = data, let _ = response else {
                completion(.failure(nil))
                return
            }

            if let decoded = try? JSONDecoder().decode(T.self, from: data) {
                completion(.success(decoded))
            } else {
                completion(.failure(nil))
            }
        }
    }

    func jsonSerializedTask<T>(
        with request: URL,
        completion: @escaping (Result<T>) -> Void
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
            if let json = try! JSONSerialization.jsonObject(with: data, options: []) as? T {
                completion(.success(json))
            } else {
                completion(.failure(nil))
            }
        }
    }
}
