//
//  DataProvider.swift
//  FileProviderApp
//
//  Created by Talov Igor on 04/10/2017.
//  Copyright © 2017 SealDev. All rights reserved.
//

import Foundation

protocol DataProviderOutput: class {
    
}

protocol DataProviderInput: class {
    func getFolderListFromRest() -> [Item]!
    func getFolderListFromLocalStorage(_ lstoragePath: String) -> [Item]!
}

class DataProvider {

    //For Test! Don'Use singletone
    static let sharedInstance = DataProvider()
    
    func getFolderListFromRest() -> [Item]! {
        
        var tempArray: [Item]! = []
        
        do {
            let file = Bundle.main.path(forResource: "Folders", ofType: "json")
            let url = URL(fileURLWithPath: file!)
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : AnyObject]
            if let itemsArray = json?["data"] as? NSArray{
                print(itemsArray)
                
                for item in itemsArray {
                    let folderItem = Item(item as! [String : AnyObject])
                    
                    print(folderItem)
                    tempArray.append(folderItem)
                }
            }
        } catch  {
            print("Error")
        }
        
        return tempArray
    }
    
    func getFolderListFromLocalStorage(_ storagePath: String) -> [Item]! {
        
        var folders: [String]! = []
        var array: [Item]! = []
        
        do {
            let array = try FileManager.default.subpathsOfDirectory(atPath: storagePath as String)
            folders.append(contentsOf: array)
        } catch {
            print("Error")
        }
        
        print(folders)
        
        for folder in folders {
            var itemArray = folder.components(separatedBy: "/")
            
            let path = folder
            let name = itemArray.last
            
            var tempDict = [String: AnyObject]()
            
            tempDict["path"] = path as AnyObject
            tempDict["name"] = name as AnyObject
            if isDirectory(folder) {
                tempDict["type"] = "folder" as AnyObject
            } else {
                tempDict["type"] = "file" as AnyObject
            }
            
            let item = Item(tempDict)
            
            array.append(item)
            print(item)
        }
        
        return array
    }
    
    //MARK: Private Methods
    
    func isDirectory(_ path: String) -> Bool {
        
        let documentFolderPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!)
        
        var isDirectory : ObjCBool = false
        let folderPath = documentFolderPath.appending("/\(path)")
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: folderPath, isDirectory:&isDirectory) {
            print(isDirectory.boolValue ? "File exists" : "Directory exists")
        } else {
            print("File does not exist")
        }
        
        return isDirectory.boolValue
        
    }
    
    
}
