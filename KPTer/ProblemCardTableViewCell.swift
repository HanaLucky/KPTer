//
//  ProblemCardTableViewCell.swift
//  KPTer
//
//  Created by yoshikawa atsushi on 3/29/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//

import Foundation
import UIKit

class ProblemCardTableViewCell: CardTableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
    func setCell (card: Card) {
        self.title.text = card.card_title
        self.detail.text = card.detail
    }
}