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
    
    func setCell (card: Card) {
        self.title.text = card.card_title
        self.detail.text = card.detail
        self.status.on = (card.status == Card.CardStatus.Open.rawValue) ? false : true
    }
}
