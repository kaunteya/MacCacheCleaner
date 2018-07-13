//
//  VersionHandler.swift
//  Mac Cache Cleaner
//
//  Created by Kaunteya Suryawanshi on 12/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import AppKit

struct VersionHandler {
    let githubURL: URL

    private func latestVersion(completion: @escaping (String) -> Void) {
        URLSession.shared.jsonSerializedTask(with: githubURL) { (result: Result<[String: Any]>) in
            switch result {
            case .success(let json):
                if let version = json["tag_name"] as? String {
                    completion(version)
                }
            case .failure(_): break
            }
            }.resume()
    }

    func showAlertForOldVersion() {
        latestVersion { version in
            let current = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
            if version != current {
                Log.info("Latest Version = \(version) current = \(current)")
                DispatchQueue.main.async(execute: self.showAlert)
            }
        }
    }

    private func showAlert() {
        let alert = NSAlert()
        alert.alertStyle = .warning

        alert.addButton(withTitle: "Close")
        alert.addButton(withTitle: "Download")

        alert.messageText = "New version available!!"
        alert.informativeText = "Please update your app for latest features & bug fixes"
        let response = alert.runModal()

        if response == .alertSecondButtonReturn {
            NSWorkspace.shared.open("https://github.com/kaunteya/MacCacheCleaner")
        }
    }
}
