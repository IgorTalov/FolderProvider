//
//  ViewController.swift
//  FileProviderApp
//
//  Created by Talov Igor on 03/10/2017.
//  Copyright © 2017 SealDev. All rights reserved.
//

import UIKit

class FolderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView?
    
    var itemsArray: [Item]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.itemsArray = DataProvider.sharedInstance.getFolderListFromRest()

       tableView?.reloadData()
       print(self.itemsArray)
    }

    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemCell = tableView.dequeueReusableCell(withIdentifier: "cellId") as! ItemCell
        
        let item = itemsArray[indexPath.row]
        
        cell.configurecellBy(item)
        
        return cell
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = self.itemsArray[indexPath.row] as! Item
        
        if item.children.count > 0 {
            let childController = FolderViewController()
            childController.itemsArray = item.children
        }
        
        
        
//        childController.
        
    }
    
}

