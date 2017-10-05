//
//  ViewController.swift
//  FileProviderApp
//
//  Created by Talov Igor on 03/10/2017.
//  Copyright © 2017 SealDev. All rights reserved.
//

import UIKit

enum FolderType: Int {
    case rootFolder = 1
    case remoteFolder = 2
    case localFolder = 3
}

class FolderViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView?
    
    var controllerType: FolderType!
    var netItemsArray = [Item]()
    var localPath = ""
    var localItemsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       tableView?.reloadData()
//       print(self.netItemsArray)
    }

}

//MARK: - UITableViewDataSource
extension FolderViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if (controllerType == FolderType(rawValue: 1)) {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if (controllerType == FolderType.rootFolder) {
            if section == 0  {
                return netItemsArray.count
            } else {
                return localItemsArray.count
            }
        } else if (controllerType == FolderType.localFolder) {
            return localItemsArray.count
        } else {
            return netItemsArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemCell = tableView.dequeueReusableCell(withIdentifier: "cellId") as! ItemCell
        
        if indexPath.section == 0 {
            let item = netItemsArray[indexPath.row]
            cell.configureCellBy(item)
            
            return cell
        } else {
            let item = localItemsArray[indexPath.row]
            let filePath = self.localPath.appending("/\(item)")
            cell.configureCellBy(item, andPath: filePath)
            
            return cell
        }
    }
}

//MARK: - UITableViewDelegate
extension FolderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if (self.controllerType == FolderType.rootFolder) {
            if indexPath.section == 0 {
                let item = self.netItemsArray[indexPath.row]
        
                if item.children.count > 0 {
                    let childController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FolderViewController") as! FolderViewController
                    childController.netItemsArray = item.children
                    self.navigationController?.pushViewController(childController, animated: true)
                }
            } else {
                let item = self.localItemsArray[indexPath.row]
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FolderViewController") as! FolderViewController
                vc.controllerType = FolderType.localFolder
                let path = self.localPath.appending("/\(item)")
                vc.localPath = path
                let array = DataProvider.sharedInstance.getLocalFolderContentAt(path)
                vc.localItemsArray = array
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if (self.controllerType == FolderType.remoteFolder) {
            
        } else {
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "  Сетевые папки"
        } else {
            return "  Локальные папки"
        }
    }
}

