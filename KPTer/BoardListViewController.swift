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
    
    // リフレッシュコントロール
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        boardEntities = BoardViewModel.findBoards(BoardViewModel.SortKey.CreatedAt, ascDesc: BoardViewModel.AscDesc.Desc)
        
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
        
        // 引っ張ってリロードする
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "まだできないよ〜")
        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        boardListTableView.addSubview(refreshControl)
        
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
        performSegueWithIdentifier(Identifiers.ToKptAreaViewController.rawValue, sender: nil)
    }
    
    /*
    KPTAreaに遷移する前処理
    ここでKptAreaViewControllerにボード、カードを渡す
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if (segue.identifier == Identifiers.ToKptAreaViewController.rawValue) {
            // KptAreaのコントローラーにボードを渡す

            let kptAreaViewController = (segue.destinationViewController as? KptAreaViewController)
            let board = self.boardEntities![boardListTableView.indexPathForSelectedRow!.row]
            kptAreaViewController!.board = board
            
        } else if (segue.identifier == Identifiers.FromAddButtonToBoardEdit.rawValue) {
            // 追加ボタンから遷移したことを示す識別子をボード画面に渡す
            let boardEditViewController = (segue.destinationViewController as? BoardEditViewController)
            boardEditViewController?.identifier = Identifiers.BoardAdd.rawValue
        }
    }
    
    /*
    Butonを拡張する
    */
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        // Editボタン
        let editButton: UITableViewRowAction = UITableViewRowAction(style: .Normal, title: "Edit") { (action, index) -> Void in
            
            tableView.editing = false
            
            // ボード編集画面に選択されたボードエンティティを渡す
            let boardEditViewController = self.storyboard?.instantiateViewControllerWithIdentifier("BoardEditViewController") as! BoardEditViewController
            let board = self.boardEntities![indexPath.row]
            
            // ボード画面をモーダル表示する
            // ボードエンティティを渡す
            boardEditViewController.board = board
            // Editボタンから遷移したことを示す識別子をボード画面に渡す
            boardEditViewController.identifier = Identifiers.BoardEdit.rawValue
            // モーダル表示する
            boardEditViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            self.presentViewController(boardEditViewController, animated: true, completion: nil)
            
        }
        
        editButton.backgroundColor = UIColor.orangeColor()
        
        // Deleteボタン
        let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .Normal , title: "Delete") { (action, index) -> Void in
            tableView.editing = false
            // ボードを削除する
            BoardViewModel.delete(self.boardEntities![indexPath.row])
            self.viewWillAppear(true)
            
        }
        deleteButton.backgroundColor = UIColor.redColor()
        
        return [deleteButton, editButton]
    }
    
    /**
     テーブルを下に引っ張ってリロードする
     (次フェーズで利用予定の仕組み)
    */
    func refresh() {
        self.viewWillAppear(true)
        self.refreshControl.endRefreshing()
    }
    
    /**
     ボードリスト画面が表示されるごとに、ボードエンティティを取得して再描画する
    */
    override func viewWillAppear(animated: Bool) {
        boardEntities = BoardViewModel.findBoards(BoardViewModel.SortKey.CreatedAt, ascDesc: BoardViewModel.AscDesc.Desc)
        boardListTableView.reloadData()
        super.viewWillAppear(animated)
    }
}

