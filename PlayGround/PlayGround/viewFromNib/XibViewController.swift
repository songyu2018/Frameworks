//
//  firstViewController.swift
//  PlayGround
//
//  Created by Yu Song on 2020-02-05.
//  Copyright © 2020 Yu Song. All rights reserved.
//

import UIKit

class XibViewController: UIViewController {

    @IBAction func addView(_ sender: UIButton) {
        let view = TestView(frame: CGRect(x: 0.0, y: 0.0, width: 300, height: 200))
        self.view.addSubview(view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
