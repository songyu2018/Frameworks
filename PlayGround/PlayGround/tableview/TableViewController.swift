//
//  TableViewController.swift
//  PlayGround
//
//  Created by Yu Song on 2020-02-04.
//  Copyright © 2020 Yu Song. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var data:[TestCodable.Person]? = TestCodable.decode()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
    }
    

    // MARK: UITableViewDataSource Delegate.
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row % 2 == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")!
                
                let contentView = cell.contentView.subviews.first as? TestView
                contentView?.btnRight.setTitle("\(data?[indexPath.row].age ?? 0)", for: .normal)
                contentView?.btnLeft.setTitle("\(data?[indexPath.row].name ?? "Undefined")", for: .normal)
            
                return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier2")!
            
            let contentView = cell.contentView.subviews.first
            (contentView?.subviews.first as! UILabel).text = "\(data?[indexPath.row].name ?? "Undefined")"
            (contentView?.subviews[1] as! UILabel).text = "\(data?[indexPath.row].age ?? 0)"
            
            return cell
        }
    }
}
