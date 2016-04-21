//
//  Identifier.swift
//  KPTer
//
//  Created by yoshikawa atsushi on 3/26/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//

import Foundation
import UIKit

public enum Identifiers:String {
    // ボード追加ボタンからボード編集画面へ遷移したことを示す識別子
    case FromAddButtonToBoardEdit = "fromAddButtonToBoardEdit"
    // ボード追加ボタンからボード編集画面へ遷移したことを示す識別子
    case FromEditButtonToBoardEdit = "fromEditButtonToBoardEdit"
    // ボード選択→KPTエリア画面遷移
    case ToKptAreaViewController = "toKptAreaViewController"
    // KPTエリア画面遷移→カード画面遷移
    case ToCardViewController = "toCardViewController"
    // カード追加ボタンからカード編集画面へ遷移したことを示す識別子
    case FromAddButtonToCardEdit = "fromAddButtonToCardEdit"
    // カード編集(セル選択)からカード編集画面へ遷移したことを示す識別子
    case FromEditButtonToCardEdit = "fromEditButtonToCardEdit"
}
