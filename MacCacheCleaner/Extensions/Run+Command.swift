//
//  Run+Command.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 25/06/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

func run(command: [String]) {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = command
    task.launch()
    //    task.waitUntilExit()
}

