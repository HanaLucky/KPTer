//
//  KptAreaViewController.swift
//  KPTer
//
//  Created by yoshikawa atsushi on 3/8/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//

import UIKit
import RealmSwift

class KptAreaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var keepTableView: UITableView!
    
    @IBOutlet weak var problemTableView: UITableView!
    
    @IBOutlet weak var tryTableView: UITableView!
    
    var board: Board? = nil
    
    var keepCardEntities: Results<Card>!
    
    var problemCardEntities: Results<Card>!
    
    var tryCardEntities: Results<Card>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = board!.board_title
        self.keepCardEntities = BoardViewModel.findKeepCard(board!)
        self.problemCardEntities = BoardViewModel.findProblemCard(board!)
        self.tryCardEntities = BoardViewModel.findTryCard(board!)
        
        // ナビゲーションバー右上に編集ボタン配置
        navigationItem.rightBarButtonItem = editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    /*
    編集モードを有効にする
    */
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.keepTableView.setEditing(editing, animated: animated)
        self.problemTableView.setEditing(editing, animated: animated)
        self.tryTableView.setEditing(editing, animated: animated)
    }
    
    /*
    Keep, Problem, Tryテーブルのセルを移動可能なセルに指定する（三本ラインの表示）
    */
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    /*
    セルが移動された時に呼び出される
    */
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        // TODO: 並び順を更新する
    }
    
    /*
    セルの編集を許可する
    */
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    /*
    削除された時に呼び出される
    */
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        var targetCard:Card? = nil

        if (TableViewTags.isKeepTableView(tableView)) {
            targetCard = keepCardEntities[indexPath.row]
        } else if (TableViewTags.isProblemTableView(tableView)) {
            targetCard = problemCardEntities[indexPath.row]
        } else if (TableViewTags.isTryTableView(tableView)) {
            targetCard = tryCardEntities[indexPath.row]
        } else {
            // XXX: アプリケーション上不正な挙動なので例外処理したい
        }
        
        cardDeleteAction(tableView, indexPath: indexPath, targetCard: targetCard!)
    }
    
    /*
    セクションの数を返す.
    */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Keep, Problem, Tryテーブルそれぞれ1セクション固定
        return 1
    }
    
    /*
    セクションのタイトルを返す.
    */
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (TableViewTags.isKeepTableView(tableView)) {
            return Card.CardType.Keep.rawValue
        } else if (TableViewTags.isProblemTableView(tableView)) {
            return Card.CardType.Problem.rawValue
        } else if (TableViewTags.isTryTableView(tableView)) {
            return Card.CardType.Try.rawValue
        }
        return "Illegal Card Type!!"
    }
    
    /*
    セクション内のセルの総数を設定する
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (TableViewTags.isKeepTableView(tableView)) {
            return keepCardEntities.count
        } else if (TableViewTags.isProblemTableView(tableView)) {
            return problemCardEntities.count
        } else if (TableViewTags.isTryTableView(tableView)) {
            return tryCardEntities.count
        }
        return 0
    }
    
    /*
    セルに表示する内容を設定する
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell? = nil
        
        if (TableViewTags.isKeepTableView(tableView)) {
            let keepCell:KeepCardTableViewCell = tableView.dequeueReusableCellWithIdentifier("KeepCard") as! KeepCardTableViewCell
            keepCell.setCell(keepCardEntities[indexPath.row])
            
            return keepCell
            
        } else if (TableViewTags.isProblemTableView(tableView)) {
            let problemCell:ProblemCardTableViewCell = tableView.dequeueReusableCellWithIdentifier("ProblemCard") as! ProblemCardTableViewCell
            problemCell.setCell(problemCardEntities[indexPath.row])
            
            return problemCell
            
        } else if (TableViewTags.isTryTableView(tableView)) {
            let tryCell:TryCardTableViewCell = tableView.dequeueReusableCellWithIdentifier("TryCard") as! TryCardTableViewCell
            tryCell.setCell(tryCardEntities[indexPath.row])
            
            return tryCell
        }
        
        return cell!
    }
    
    /*
    Card画面に遷移する前処理
    ここでCardViewControllerにボード、カードを渡す
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // CardViewControllerに必要情報を渡す
        let cardViewController = segue.destinationViewController as! CardViewController

        if (Identifiers.isCardAdd(segue.identifier!)) {
            // 追加ボタンの処理
            // 追加ボタンから遷移したことを示す識別子をカード画面に渡す
            cardViewController.identifier = segue.identifier!
            
        } else if (Identifiers.isCardEdit(segue.identifier!)) {
            // セル選択時の処理
            // カードとセル選択されたことを示す識別子をカード画面に渡す
            let cardTableViewCell = sender as! CardTableViewCell
            
            var card: Card = Card()
            
            if (cardTableViewCell is KeepCardTableViewCell) {
                let index = self.keepTableView.indexPathForCell(cardTableViewCell)
                card = self.keepCardEntities[index!.row]
            } else if (cardTableViewCell is ProblemCardTableViewCell) {
                let index = self.problemTableView.indexPathForCell(cardTableViewCell)
                card = self.problemCardEntities[index!.row]
            } else if (cardTableViewCell is TryCardTableViewCell) {
                let index = self.tryTableView.indexPathForCell(cardTableViewCell)
                card = self.tryCardEntities[index!.row]
            }
            
            cardViewController.card = card
            
            cardViewController.identifier = segue.identifier!
        }
        
        cardViewController.board = self.board
    }
    
    /**
     KPTエリア画面が表示されるごとに、カードエンティティを取得して再描画する
     */
    override func viewWillAppear(animated: Bool) {
        self.refreshView()
        super.viewWillAppear(animated)
    }
    
    /*
    画面内の値をリフレッシュする
    */
    private func refreshView() {
        self.navigationItem.title = self.board!.board_title
        self.keepCardEntities = BoardViewModel.findKeepCard(self.board!)
        self.problemCardEntities = BoardViewModel.findProblemCard(self.board!)
        self.tryCardEntities = BoardViewModel.findTryCard(self.board!)
        
        self.keepTableView.reloadData()
        self.problemTableView.reloadData()
        self.tryTableView.reloadData()
        
    }
    
    /*
    カード削除
    - parameter tableView: 処理対象のテーブルビュー
    - parameter indexPath: 削除対象のセルインデックス
    - parameter targetCard: 削除対象のカード
    */
    private func cardDeleteAction(tableView: UITableView, indexPath: NSIndexPath, targetCard: Card) {

        if (targetCard.isKeep() || targetCard.isProblem()) {
            // Keep, Problemカードの場合、リレーションが存在するか確認。確認後リレーション先のTryカードも同時に削除する
            
            if let tryCard:Card = CardViewModel.findFromCardRelation(targetCard) {
                // 紐付け先のTryカードが存在する場合、警告ポップアップを表示する
                // 削除確認アラートを表示する
                let alertController = UIAlertController(title: "Caution!", message: "Related Try card will be deleted. Are you sure you want to delete this card?", preferredStyle: .Alert)
            
                // OKボタン押下時
                let defaultAction = UIAlertAction(title: "OK", style: .Default) {
                    // OKの場合、紐付け先のTryカード、リレーション、Keepカードを削除する。
                    action in CardViewModel.deleteCardRelation(tryCard)
                    CardViewModel.delete(tryCard)
                    CardViewModel.delete(targetCard)
                
                    // それからテーブルビューの更新
                    tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 0)],withRowAnimation: UITableViewRowAnimation.Fade)
                    // Tryカードテーブルビューに削除されたTryカードの表示が残らないように、Tryテーブルビューも更新する
                    self.tryCardEntities = BoardViewModel.findTryCard(self.board!)
                    self.tryTableView.reloadData()
                }
            
                // CANCELボタン押下時
                let cancelAction = UIAlertAction(title: "CANCEL", style: .Cancel) {
                    action in // 何もしない
                }
                
                alertController.addAction(defaultAction)
                alertController.addAction(cancelAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                CardViewModel.delete(targetCard)
                // それからテーブルビューの更新
                tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 0)],withRowAnimation: UITableViewRowAnimation.Fade)
            }
            
        } else if (targetCard.isTry()) {
            // Tryカードの場合、リレーションと自分自身を削除する
            CardViewModel.deleteCardRelation(targetCard)
            CardViewModel.delete(targetCard)
            
            // それからテーブルビューの更新
            tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 0)],withRowAnimation: UITableViewRowAnimation.Fade)
        } else {
            // XXX: 例外処理
        }
    }
}
