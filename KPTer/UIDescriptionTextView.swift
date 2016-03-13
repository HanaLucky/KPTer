//
//  UIDescriptionTextView.swift
//  KPTer
//
//  Created by yoshikawa atsushi on 3/12/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//

import UIKit

class UIDescriptionTextView: UITextView {
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        // 角に丸みをつける
        self.layer.masksToBounds = true
        
        // 角の丸みを設定
        self.layer.cornerRadius = 8
        
        // 枠線の太さを設定
        self.layer.borderWidth = 0.2
        
        // 枠線の色を黒に設定
        self.layer.borderColor = UIColor.grayColor().CGColor
        
        // フォントの色の設定
        self.textColor = UIColor.blackColor()
        
        // 左詰めの設定
        self.textAlignment = NSTextAlignment.Left
        
        // リンク、日付などを自動的に検出してリンクに変換
        self.dataDetectorTypes = UIDataDetectorTypes.All
        
        // 影の濃さを設定
        self.layer.shadowOpacity = 0.5
    }
}
