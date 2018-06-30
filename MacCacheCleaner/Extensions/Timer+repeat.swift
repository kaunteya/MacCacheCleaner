//
//  Timer+repeat.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 30/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//
import Foundation

extension Timer {
    @discardableResult
    class func every(_ timeInterval: TimeInterval, f: @escaping (Timer) -> Void) -> Timer {
        return scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: f)
    }
}
