//
//  ViewController.swift
//  KPTer
//
//  Created by yoshikawa atsushi on 2/8/16.
//  Copyright © 2016 yoshikawa atsushi. All rights reserved.
//

import UIKit
import FlatUIKit
import RealmSwift

class BoardListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // BoardListに表示するエンティティ
    var boardEntities: Results<Board>?
    
    // テーブルビュー
    @IBOutlet weak var boardListTableView: UITableView!
    // リフレッシュコントロール
    var refreshControl:UIRefreshControl!
    
    // ボードリストのリフレッシュが必要かのフラグ
    var needRefresh = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        boardEntities = BoardViewModel.findBoards(BoardViewModel.SortKey.CreatedAt, ascDesc: BoardViewModel.AscDesc.Desc)
        
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("BoardListItem", forIndexPath: indexPath)
        
        // cellに対し、UIFlatKit適応
        let corners = UIRectCorner.AllCorners
        cell.configureFlatCellWithColor(UIColor(red: 251/255, green: 168/255, blue: 72/255, alpha: 1.0), selectedColor: .whiteColor(), roundingCorners: corners)
        cell.cornerRadius = 5;
        cell.separatorHeight = 2;
        
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
    画面遷移する前処理
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if (Identifiers.isToKptAreaViewController(segue.identifier!)) {
            // KptAreaのコントローラーにボードを渡す
            let kptAreaViewController = (segue.destinationViewController as? KptAreaViewController)
            let board = self.boardEntities![boardListTableView.indexPathForSelectedRow!.row]
            kptAreaViewController!.board = board
            self.needRefresh = false
        } else if (Identifiers.isBoardAdd(segue.identifier!)) {
            // 追加ボタンから遷移したことを示す識別子をボード画面に渡す
            let boardEditViewController = (segue.destinationViewController as? BoardEditViewController)
            boardEditViewController?.identifier = Identifiers.FromAddButtonToBoardEdit.rawValue
            self.needRefresh = true
        }
    }
    
    /*
    Buttonを拡張する
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
            boardEditViewController.identifier = Identifiers.FromEditButtonToBoardEdit.rawValue
            self.needRefresh = true
            // モーダル表示する
            boardEditViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            self.presentViewController(boardEditViewController, animated: true, completion: nil)
            
        }
        
        editButton.backgroundColor = UIColor.orangeColor()
        
        // Deleteボタン
        let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .Normal , title: "Delete") { (action, index) -> Void in
            // 削除確認アラートを表示する
            let alertController = UIAlertController(title: "Caution!", message: "Are you sure you want to delete '\(self.boardEntities![index.row].board_title)'.", preferredStyle: .Alert)
            
            // OKボタン押下時
            let defaultAction = UIAlertAction(title: "OK", style: .Default) {
                action in BoardViewModel.delete(self.boardEntities![indexPath.row])
                self.needRefresh = true
                self.viewWillAppear(true)
            }
            
            // CANCELボタン押下時
            let cancelAction = UIAlertAction(title: "CANCEL", style: .Cancel) {
                action in tableView.editing = false
            }
            
            alertController.addAction(defaultAction)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
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
        super.viewWillAppear(animated)
        
        if let indexPathForSelectedRow = boardListTableView.indexPathForSelectedRow {
            boardListTableView.deselectRowAtIndexPath(indexPathForSelectedRow, animated: true)
        }

        if (self.needRefresh) {
            boardEntities = BoardViewModel.findBoards(BoardViewModel.SortKey.CreatedAt, ascDesc: BoardViewModel.AscDesc.Desc)
            boardListTableView.reloadData()
        }
    }
}

