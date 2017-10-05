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

    func configureCellBy(_ item: Item) {
        self.nameLabel.text = item.name
        
        if item.type == "folder" {
            self.imageView?.image = UIImage(named: "folder")
        } else {
            let imageName = imageForType(item)
            self.imageView?.image = UIImage(named: imageName)
        }
    }
    
    func configureCellBy(_ fileName: String, andPath: String) {
        self.nameLabel.text = fileName
        
        if !FileManager.default.isDirectory(fileName, path: andPath) {
            self.imageView?.image = UIImage(named: "folder")
        } else {
            let ext = fileName.components(separatedBy: ".").last!
            self.imageView?.image = UIImage(named: imageNameForFileExtension(ext))
        }
    }
    
    
    //Скорее всего вынести в расштрение
    func imageNameForFileExtension(_ fileExtension: String) -> String {
        let filesExtansionsSet = Set(arrayLiteral: "avi","css","html","iso","fla","rtf","xml","png","jpg","ppt","xls","json","txt","doc","zip")
        if filesExtansionsSet.contains(fileExtension) {
            return fileExtension
        } else {
            return "someFile"
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
