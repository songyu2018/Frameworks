//
//  ControlPanel.swift
//  WKWebViewDemoApp
//
//  Created by Nicky on 2019-03-29.
//  Copyright © 2019 Raymond Kim. All rights reserved.
//

import Foundation
import UIKit
import UtilityFramework


@IBDesignable
class ControlPanel: XibView {
    
    
    @IBOutlet weak var playBtn: UIButton!
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        playBtn.layer.cornerRadius = playBtn.bounds.size.height / 2
        playBtn.clipsToBounds = true
    }
    
    
}
