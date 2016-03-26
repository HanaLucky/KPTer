//
//  ViewController.swift
//  KPTer
//
//  Created by yoshikawa atsushi on 2/8/16.
//  Copyright © 2016 yoshikawa atsushi. All rights reserved.
//

import UIKit
import RealmSwift

class BoardListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // BoardListに表示するエンティティ
    var boardEntities: Results<Board>?
    
    // テーブルビュー
    private var boardListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // XXX test code for insert data start
        for var i = 0; i < 3; i++ {
            BoardViewModel.create("new board title" + String(i))
        }
        BoardViewModel.create("new board title")
        let realm = try! Realm()
        boardEntities = realm.objects(Board)
        // XXX test code for insert data end
        
        // reference https://sites.google.com/a/gclue.jp/swift-docs/ni-yinki100-ios/uikit/006-uitableviewdeteburuwo-biao-shi
        // Status Barの高さを取得する.
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        
        // Navigation Barの高さを取得する
        let navigationBarHeight = self.navigationController?.navigationBar.frame.height
        
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // TableViewの生成する(status bar, navigation barの高さ分ずらして表示).
        boardListTableView = UITableView(frame: CGRect(x: 0, y: barHeight + navigationBarHeight!, width: displayWidth, height: displayHeight - barHeight - navigationBarHeight!))
        
        // Cell名の登録をおこなう.
        boardListTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceの設定をする.
        boardListTableView.dataSource = self
        
        // Delegateを設定する.
        boardListTableView.delegate = self
        
        // Viewに追加する.
        self.view.addSubview(boardListTableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    Cellの総数を返すデータソースメソッド.(実装必須)
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boardEntities!.count
    }
    
    /*
    Cellに値を設定するデータソースメソッド.(実装必須)
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        
        // Cellに値を設定する.
        cell.textLabel!.text = boardEntities![indexPath.row].board_title
        
        return cell
    }
    
    // @TODO implementes seque to KPT Area
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            tableView.reloadData()
        }
    }
    
    /*
    Cellが選択された際に呼び出される.
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("toKptAreaViewController", sender: nil)
    }
    
    /*
    KPTAreaに遷移する前処理
    ここでKptAreaViewControllerにボード、カードを渡す
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toKptAreaViewController") {
            let toKptAreaViewController = (segue.destinationViewController as? KptAreaViewController)
            // @TODO implements
        }
    }
    
    /*
    Butonを拡張する
    */
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        // Editボタン
        let editButton: UITableViewRowAction = UITableViewRowAction(style: .Normal, title: "Edit") { (action, index) -> Void in
            tableView.editing = false
            print("Edit")
            // @TODO 編集がタップされた場合の処理。Board Edit画面をモーダル表示する

            let boardEditViewController = self.storyboard?.instantiateViewControllerWithIdentifier("BoardEditViewController") as! BoardEditViewController
            
            let board = self.boardEntities![indexPath.row]
            
            boardEditViewController.board = board
            boardEditViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            self.presentViewController(boardEditViewController, animated: true, completion: nil)
            
        }
        
        editButton.backgroundColor = UIColor.orangeColor()
        
        // Deleteボタン
        let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .Normal , title: "Delete") { (action, index) -> Void in
            tableView.editing = false
            print("delete")
        }
        deleteButton.backgroundColor = UIColor.redColor()
        
        return [deleteButton, editButton]
    }
}

