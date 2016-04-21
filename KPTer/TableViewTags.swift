//
//  TableViewTags.swift
//  KPTer
//
//  Created by yoshikawa atsushi on 3/31/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//

import Foundation
import UIKit

public enum TableViewTags: Int {
    case KeepTableViewTag = 0
    case ProblemTableViewTag = 1
    case TryTableViewTag = 2
    
    /**
     Keepカードテーブルビューか
     - parameter tableView: テーブルビュー
     - returns: true YES、false NO
     */
    static func isKeepTableView(tableView: UITableView) -> Bool {
        return tableView.tag == TableViewTags.KeepTableViewTag.rawValue ? true : false
    }
    
    /**
     Problemカードテーブルビューか
     - parameter tableView: テーブルビュー
     - returns: true YES、false NO
     */
    static func isProblemTableView(tableView: UITableView) -> Bool {
        return tableView.tag == TableViewTags.ProblemTableViewTag.rawValue ? true : false
    }
    
    /**
     Tryカードテーブルビューか
     - parameter tableView: テーブルビュー
     - returns: true YES、false NO
     */
    static func isTryTableView(tableView: UITableView) -> Bool {
        return tableView.tag == TableViewTags.TryTableViewTag.rawValue ? true : false
    }
}
