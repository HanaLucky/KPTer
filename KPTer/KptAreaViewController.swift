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
        // experimentData()
        self.navigationItem.title = board!.board_title
        self.keepCardEntities = BoardViewModel.findKeepCard(board!)
        self.problemCardEntities = BoardViewModel.findProblemCard(board!)
        self.tryCardEntities = BoardViewModel.findTryCard(board!)
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
    
    private func refreshView() {
        self.navigationItem.title = self.board!.board_title
        self.keepCardEntities = BoardViewModel.findKeepCard(self.board!)
        self.problemCardEntities = BoardViewModel.findProblemCard(self.board!)
        self.tryCardEntities = BoardViewModel.findTryCard(self.board!)
        
        self.keepTableView.reloadData()
        self.problemTableView.reloadData()
        self.tryTableView.reloadData()
        
    }
}
