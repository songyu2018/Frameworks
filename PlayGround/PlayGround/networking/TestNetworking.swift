//
//  TestNetworking.swift
//  PlayGround
//
//  Created by Yu Song on 2020-02-05.
//  Copyright © 2020 Yu Song. All rights reserved.
//

import UIKit
import NetworkFramework



class TestNetworking: UITableViewController {

    let url = "https://my-json-server.typicode.com/songyu2018/Frameworks/db"
    var posts: [Post] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkingManager.shared.dataTask(method: .GET, sURL: url, headers: nil, body: nil) { (success, responseObject) in
            if let response = responseObject.response {
                print(response)
                self.parseData(data: response)
            }
        }
        
        NetworkingManager.shared.get(url: url) { result in
            switch result {
            case.results(let results):
                print("Result: \(results)")
                self.parseData(data: results.self)
            case.error(let error):
                print("Error: \(error)")
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    private func parseData(data: Any) {
        do {
            let data = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            let model = try JSONDecoder().decode(Posts.self, from: data)
            if let posts = model.posts {
                self.posts = posts
            }
            self.tableView.reloadData()
        } catch { print(error) }
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

        cell.textLabel?.text = "The post id is: \(posts[indexPath.row].id!)"
        cell.detailTextLabel?.text = posts[indexPath.row].title

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
