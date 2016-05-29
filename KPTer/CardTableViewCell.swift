//
//  CardTableViewCell.swift
//  KPTer
//
//  Created by yoshikawa atsushi on 3/29/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        // cellに対し、UIFlatKit適応
        let corners = UIRectCorner.AllCorners
        self.configureFlatCellWithColor(.whiteColor(), selectedColor: UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0), roundingCorners: corners)
        self.cornerRadius = 5;
        self.separatorHeight = 2;
        self.backgroundColor = UIColor(red: 33/255, green: 183/255, blue: 182/255, alpha: 1.0)
    }
    
    func setCell (card: Card) {
        self.textLabel?.text = card.card_title
        self.detailTextLabel?.text = card.detail
    }
    
}
