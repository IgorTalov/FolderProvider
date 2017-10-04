//
//  ItemCell.swift
//  FileProviderApp
//
//  Created by Talov Igor on 04/10/2017.
//  Copyright © 2017 SealDev. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configurecellBy(_ item: Item) {
        self.nameLabel.text = item.name
        
        if item.type == "folder" {
            self.imageView?.image = UIImage(named: "folder")
        } else {
            let imageName = imageForType(item)
            self.imageView?.image = UIImage(named: imageName)
        }
    }
    
    func imageForType(_ item: Item) -> String {
        
        let filesExtansionsSet = Set(arrayLiteral: "avi","css","html","iso","fla","rtf","xml","png","jpg","ppt","xls","json","txt","doc","zip")
        let fileExtansion = item.name.components(separatedBy: ".").last
        
        if filesExtansionsSet.contains(fileExtansion!) {
            return fileExtansion!
        } else {
            return "someFile"
        }
    }
    
}
