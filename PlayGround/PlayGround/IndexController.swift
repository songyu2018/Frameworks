//
//  IndexControllerTableViewController.swift
//  PlayGround
//
//  Created by Yu Song on 2020-02-04.
//  Copyright © 2020 Yu Song. All rights reserved.
//

import UIKit

class IndexController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        switch indexPath.row {
        case 0:
            (cell.contentView.subviews.first as! UILabel).text = "UITableView Playground (Storyboard)"
        case 1:
            (cell.contentView.subviews.first as! UILabel).text = "Test Networking (Storyboard)"
        case 2:
            (cell.contentView.subviews.first as! UILabel).text = "Test Xib View (Storyboard)"
        case 3:
            (cell.contentView.subviews.first as! UILabel).text = "Test Animation (Nib)"
        default:
            cell.detailTextLabel?.text = "UITableView Playground"
        }

        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var vc: UIViewController? = nil
        var controllerName = ""
        switch indexPath.row {
        case 0:
            controllerName = "TableviewPlayground"
        case 1:
            controllerName = "TestNetworking"
        case 2:
            controllerName = "XibViewController"
        case 3:
            vc = AnimationViewController.loadFromNib()
        default:
            controllerName = "TableviewPlayground"
        }
    
        if indexPath.row < 3 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            vc = storyboard.instantiateViewController(withIdentifier: controllerName)
        }
        
        if let controller = vc {
            self.navigationController!.pushViewController(controller, animated: true)
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
