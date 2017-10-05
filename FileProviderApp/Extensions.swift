//
//  Extensions.swift
//  FileProviderApp
//
//  Created by Talov Igor on 05/10/2017.
//  Copyright © 2017 SealDev. All rights reserved.
//

import Foundation

extension FileManager {
    
    func isDirectory(_ fileName: String, path: String) -> Bool {
        
        var isDirectory : ObjCBool = false
        let filePath = path.appending("/\(fileName)")

        if fileExists(atPath: filePath, isDirectory: &isDirectory) {
            print(isDirectory.boolValue ? "Directory exists" : "File exists")
        } else {
            print("File does not exist")
        }
        
        return isDirectory.boolValue
    }
    
}
