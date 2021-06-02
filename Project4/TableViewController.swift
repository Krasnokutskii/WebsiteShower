//
//  TableViewController.swift
//  Project4
//
//  Created by Ярослав on 3/26/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    var websites = ["apple.com","hackingwithswift.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

 
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Site", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Site") as? WebViewController{
            
            if indexPath.row == 0{
                vc.websites = websites
            }else{
                vc.websites = websites.reversed()
            }
        navigationController?.pushViewController(vc, animated: true)
        }
    }
    

}
