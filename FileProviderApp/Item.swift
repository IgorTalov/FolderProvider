//
//  Item.swift
//  FileProviderApp
//
//  Created by Talov Igor on 03/10/2017.
//  Copyright © 2017 SealDev. All rights reserved.
//

import Foundation

enum Type {
    case folder
    case file
}

class Item: NSObject {
    
//    var isRoot: Bool = false
//    var type: Type!
    var type = ""
    var children = [Item]()
    var path = ""
    var name = ""
    
    init(_ dictinary: [String: AnyObject]) {
        super.init()
        
        self.type = dictinary["type"] as! String
        self.path = dictinary["path"] as! String
        self.name = dictinary["name"] as! String
        
        if self.type == "folder" {
            if (dictinary["children"] != nil) {
                let childArray = dictinary["children"] as! NSArray
                
                for child in childArray {
                    let item = Item(child as! [String : AnyObject])
                    
                    self.children.append(item)
                }
            }
        }

    }
    
    
}
