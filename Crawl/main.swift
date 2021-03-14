//
//  main.swift
//  Crawl
//
//  Created by Yuki Tsukada on 2021/03/12.
//

import Foundation

let fileManager = FileManager.default
let path = fileManager.currentDirectoryPath
let pathURL = URL(string: path)

func printDirectoryURL(path: URL, prefix: String) {
    do {
        let items = try fileManager.contentsOfDirectory(at: path, includingPropertiesForKeys: [URLResourceKey.isDirectoryKey])

        for (index, item) in items.enumerated() {
            let isDir = (try item.resourceValues(forKeys: [.isDirectoryKey])).isDirectory
            
            if index == items.count - 1 {
                print(prefix + "└─ \(item.lastPathComponent)")
                if isDir == true {
                    printDirectoryURL(path: item, prefix: prefix + "     ")
                }

            } else {
                print(prefix + "├─ \(item.lastPathComponent)")
                if isDir == true {
                    printDirectoryURL(path: item, prefix: prefix + "│    ")
                }
            }
        }
    } catch {
        print("Reading failed.")
    }
}

if fileManager.fileExists(atPath: path, isDirectory: nil) == true {
    print(path)
    printDirectoryURL(path: pathURL!, prefix: "")
    // for checking
//    let filePathURL = URL(fileURLWithPath: "/Users/yuki.t/Desktop/Swift_X-code")
//    printDirectoryURL(path: filePathURL, prefix: "")
}

