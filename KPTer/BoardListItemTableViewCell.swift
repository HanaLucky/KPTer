//
//  BoardListItemTableViewCell.swift
//  KPTer
//
//  Created by yoshikawa atsushi on 2/8/16.
//  Copyright © 2016 yoshikawa atsushi. All rights reserved.
//

import UIKit

class BoardListItemTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        // cellに対し、UIFlatKit適応
        let corners = UIRectCorner.AllCorners
        self.configureFlatCellWithColor(.whiteColor(), selectedColor: UIColor(red: 18/255, green: 83/255, blue: 164/255, alpha: 1.0), roundingCorners: corners)
        self.cornerRadius = 5
        self.separatorHeight = 2
        self.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1.0)
        // 反転時にも角丸にする
        self.selectedBackgroundView?.layer.cornerRadius = 5
    }

}
