//
//  TryCardTableViewCell.swift
//  KPTer
//
//  Created by yoshikawa atsushi on 3/29/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//

import Foundation
import UIKit
import BEMCheckBox

class TryCardTableViewCell: CardTableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var detail: UILabel!
    
    @IBOutlet weak var status: BEMCheckBox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.status.onAnimationType = BEMAnimationType.Bounce
        self.status.offAnimationType = BEMAnimationType.Bounce
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        // cellに対し、UIFlatKit適応
        self.title.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
        self.detail.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
    }
    
    override func setCell (card: Card) {
        self.title.text = card.card_title
        self.detail.text = card.detail

        self.status.on = (card.status == Card.CardStatus.Open.rawValue) ? false : true
    }
}
