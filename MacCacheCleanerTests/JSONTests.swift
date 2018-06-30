//
//  JSONTests.swift
//  MacCacheCleanerTests
//
//  Created by Kaunteya Suryawanshi on 30/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import XCTest

extension String {
    var jsonToDictionary: [String: Any] {
        let data = self.data(using: .utf8)!
        return try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
    }
}

class JSONTests: XCTestCase {

    func JSONFrom(file: String) -> [String: Any] {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: file, ofType: "json")!
        let url = URL(fileURLWithPath: path)
        let str = try! String(contentsOf: url, encoding: .utf8)
        return str.jsonToDictionary
    }


    func testVersion() {
        let file = JSONFrom(file: "Source")
        XCTAssertNotNil(file["version"])
    }

    func testList() {
        let file = JSONFrom(file: "Source")
        XCTAssertNotNil(file["items"] as? [[String : Any]])
        let list = file["items"] as! [[String : Any]]

        let dictKeys = Set<String>([ "id", "name", "description", "location", "image" ])
        list.forEach { itemDict in
            XCTAssert(Set<String>(itemDict.keys).isSuperset(of: dictKeys))
        }

    }


}
