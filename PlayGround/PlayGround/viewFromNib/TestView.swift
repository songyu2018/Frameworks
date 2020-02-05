//
//  TestView.swift
//  testNib
//
//  Created by Yu Song on 2020-01-29.
//  Copyright © 2020 Yu Song. All rights reserved.
//




import UIKit
import UtilityFramework

/*
    How to setup:
        1. In the nib file, chose the `File's Owner` and then set the `Class` field to `TestView`
        2. Keep the `Class` field of the `View` as `UIView`, otherwise it can run into deadloop situation.
        3. Setup the `IBOutlets` and `IBAcitons` to this class not the super class `XibView`
*/
class TestView: XibView {

    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    
    // Override this method to load the correct nib file.
    override func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: String(describing: TestView.self), bundle: Bundle(for: type(of: self)))
        return nib.instantiate(withOwner: self,options: nil).first as? UIView
    }
    
    
    // To create a new IBAction: control-drag from the nib to here.
    @IBAction func onLeftClicked(_ sender: UIButton) {
        let person = TestCodable.decode()?.first
        
        if (person != nil) {
            sender.setTitle(person!.name, for: .normal)
            btnRight.setTitle(String(person!.age), for: .normal)
        }
    }
    
    // To connect to an existing IBAction already exist here: control-drag from the UI component (within the nib) to the File's Owner (within the nib)
    @IBAction func onRightClicked(_ sender: UIButton) {
        sender.setTitle("Clcked", for: .normal)
    }
}
