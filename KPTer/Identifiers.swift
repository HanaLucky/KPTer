//
//  Identifier.swift
//  KPTer
//
//  Created by yoshikawa atsushi on 3/26/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//

import Foundation

public enum Identifiers:String {
    // ボード追加ボタンからボード編集画面へ遷移したことを示す識別子
    case FromAddButtonToBoardEdit = "fromAddButtonToBoardEdit"
    // ボード編集ボタンからボード編集画面へ遷移したことを示す識別子
    case FromEditButtonToBoardEdit = "fromEditButtonToBoardEdit"
    // カード追加ボタンからカード編集画面へ遷移したことを示す識別子
    case FromAddButtonToCardEdit = "fromAddButtonToCardEdit"
    // カード編集(セル選択)からカード編集画面へ遷移したことを示す識別子
    case FromEditButtonToCardEdit = "fromEditButtonToCardEdit"
    
    // KPTエリア画面遷移
    case ToKptAreaViewController = "toKptAreaViewController"

    /**
     ボード追加アクションとして遷移したか
     - parameter identifer: 画面遷移識別子
     - returns: true した、false していない
     */
    static func isBoardAdd(identifer: String) -> Bool {
        return identifer == self.FromAddButtonToBoardEdit.rawValue ? true : false
    }
    
    /**
     ボード編集アクションとして遷移したか
     - parameter identifer: 画面遷移識別子
     - returns: true した、false していない
     */
    static func isBoardEdit(identifer: String) -> Bool {
        return identifer == self.FromEditButtonToBoardEdit.rawValue ? true : false
    }
    
    /**
     カード追加アクションとして遷移したか
     - parameter identifer: 画面遷移識別子
     - returns: true した、false していない
     */
    static func isCardAdd(identifer: String) -> Bool {
        return identifer == self.FromAddButtonToCardEdit.rawValue ? true : false
    }
    
    /**
     カード編集アクションとして遷移したか
     - parameter identifer: 画面遷移識別子
     - returns: true した、false していない
     */
    static func isCardEdit(identifer: String) -> Bool {
        return identifer == self.FromEditButtonToCardEdit.rawValue ? true : false
    }
    
    /**
     KPTエリアへの遷移アクションか
     - parameter identifer: 画面遷移識別子
     - returns: true した、false していない
     */
    static func isToKptAreaViewController(identifer: String) -> Bool {
        return identifer == self.ToKptAreaViewController.rawValue ? true : false
    }
}

