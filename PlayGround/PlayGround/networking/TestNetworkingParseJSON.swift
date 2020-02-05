//
//  TestNetworking.swift
//  PlayGround
//
//  Created by Yu Song on 2020-02-05.
//  Copyright © 2020 Yu Song. All rights reserved.
//

import UIKit
import NetworkFramework



class TestNetworkingParseJSON: UITableViewController {

    let url = "https://my-json-server.typicode.com/songyu2018/Frameworks/db"
    var posts: [[String: AnyObject]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkingManager.shared.dataTask(method: .GET, sURL: url, headers: nil, body: nil) { (success, dictResponse) in
                           print(dictResponse)
            if let response: [String: AnyObject] = dictResponse[NetworkingManager.RESPONSE] as? [String: AnyObject]{
                self.parseJSON(data: response)
            }
        }
    }
    
    private func parseJSON(data: [String: AnyObject]) {
        print("Parsing the JSON data: \(data)")
        if let posts = data["posts"] {
            self.posts = posts as! [[String : AnyObject]]
        }
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = "The post id is: \(String(describing: posts[indexPath.row].keys.first))"
        cell.detailTextLabel?.text = "\(String(describing: posts[indexPath.row].values.first))"

        return cell
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
