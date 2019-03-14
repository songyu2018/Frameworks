//
//  IconButton.swift
//  Neon
//
//  Created by Mike on 9/26/15.
//  Copyright © 2015 Mike Amaral. All rights reserved.
//

import UIKit
import Neon


class IconButton: UIView {
    let imageView : UIImageView = UIImageView()
    let label : UILabel = UILabel()

    convenience init() {
        self.init(frame: CGRect.zero)

        imageView.contentMode = .scaleAspectFill
        self.addSubview(imageView)

        label.textAlignment = .center
        label.textColor = UIColor(red: 106/255.0, green: 113/255.0, blue: 127/255.0, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 13.0)
        self.addSubview(label)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        imageView.anchorToEdge(.top, padding: 0, width: 24, height: 24)
        label.align(.underCentered, relativeTo: imageView, padding: 5, width: self.width, height: 15)
    }
}
