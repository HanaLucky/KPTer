//
//  UITypeLabel.swift
//  KPTer
//
//  Created by yoshikawa atsushi on 3/12/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//

import UIKit

class UITypeLabel: UILabel {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        self.text = "test"
        self.textColor = UIColor.grayColor()
    }
}
