//
//  CardViewController.swift
//  KPTer
//
//  Created by yoshikawa atsushi on 3/11/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//

import UIKit
import RealmSwift

class CardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var typeSegment: UISegmentedControl!
    // card title field
    @IBOutlet weak var titleField: UITextField!
    // description field
    @IBOutlet weak var descriptionField: UITextView!
    // relation card table view
    @IBOutlet weak var relationCardTableView: UITableView!
    // KPTエリアから受け取るボード
    var board: Board! = nil
    // KPTエリアから受け取るカード
    var card: Card? = nil
    // 画面遷移の識別子(ボード一覧のAddから来たかEditからきたか判別)
    var identifier: String = ""
    
    enum CardTypeSegmentIndex: Int {
        case Keep = 0
        case Problem = 1
        case Try = 2
    }
    
    let relationCardTableSections = [Card.CardType.Keep.rawValue, Card.CardType.Problem.rawValue]
    
    var keepCardEntities: Results<Card>!
    
    var problemCardEntities: Results<Card>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        // カードエンティティが渡ってきたら（基本、編集時のみ）
        if let cardEntity = card {
            typeSegment.selectedSegmentIndex = self.getSegmentIndexFromCardType(cardEntity)
            titleField.text = cardEntity.card_title
            descriptionField.text = cardEntity.detail
        }
        keepCardEntities = BoardViewModel.findKeepCard(self.board)
        problemCardEntities = BoardViewModel.findKeepCard(self.board)

        // カードエンティティが渡ってこない場合は何もしない
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        if (self.identifier == Identifiers.FromAddButtonToCardEdit.rawValue) {
            // カード追加
            if (self.typeSegment.selectedSegmentIndex == CardTypeSegmentIndex.Keep.rawValue) {
                BoardViewModel.addKeepCard(self.board!, title: self.titleField.text!, detail: self.descriptionField.text)
            } else if (self.typeSegment.selectedSegmentIndex == CardTypeSegmentIndex.Problem.rawValue) {
                BoardViewModel.addProblemCard(self.board!, title: self.titleField.text!, detail: self.descriptionField.text)
            } else if (self.typeSegment.selectedSegmentIndex == CardTypeSegmentIndex.Try.rawValue) {
                // FIXME: Tryカードの紐付け元を設定する
                //BoardViewModel.addTryCard(<#T##board: Board##Board#>, title: <#T##String#>, detail: <#T##String#>, fromCard: <#T##Card#>)
                print("add try card!!")
            }
            
        } else if (self.identifier == Identifiers.FromEditButtonToCardEdit.rawValue) {
            // カード編集
            let editCard: Card = Card()
            editCard.card_title = self.titleField.text!
            editCard.detail = self.descriptionField.text
            editCard.type = self.getCardTypeFromSegmentIndex(self.typeSegment.selectedSegmentIndex).rawValue
            CardViewModel.edit(self.card!, editCard: editCard)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /**
    カードタイプに紐づくセグメントindexを取得する
    
    - parameter card: カードエンティティ
    
    - returns: カードタイプのセグメントindex
    */
    private func getSegmentIndexFromCardType (card: Card) -> Int {
        switch card.type {
        case Card.CardType.Keep.rawValue:
            return CardTypeSegmentIndex.Keep.rawValue
        case Card.CardType.Problem.rawValue:
            return CardTypeSegmentIndex.Problem.rawValue
        case Card.CardType.Try.rawValue:
            return CardTypeSegmentIndex.Try.rawValue
        default:
            return 0
            // FIXME: 想定外のタイプである場合例外処理とする
            // throw NSError(domain: "illegal card type. card type is [" + card.type + "]", code: -1, userInfo: nil)
        }
    }
    
    /**
     セグメントindexに紐づくカードタイプを取得する
     
     - parameter segmentIndex: カードタイプのセグメントindex
     
     - returns: カードタイプ
     */
    private func getCardTypeFromSegmentIndex(segmentIndex: Int) -> Card.CardType {
        switch segmentIndex {
        case CardTypeSegmentIndex.Keep.rawValue:
            return Card.CardType.Keep
        case CardTypeSegmentIndex.Problem.rawValue:
            return Card.CardType.Problem
        case CardTypeSegmentIndex.Try.rawValue:
            return Card.CardType.Try
        default:
            // FIXME: 想定外のセグメントindexである場合例外処理とする
            // throw NSError(domain: "illegal segment index. segment index is [" + segmentIndex + "]", code: -1, userInfo: nil)
            return Card.CardType.Keep
        }
    }
    
    /*
    segmentが切り替わったときに呼ばれるイベント
    */
    func segmentedControlChanged(sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == CardTypeSegmentIndex.Try.rawValue) {
            // relationテーブルにカードを表示する
            keepCardEntities = BoardViewModel.findKeepCard(self.board)
            problemCardEntities = BoardViewModel.findKeepCard(self.board)
        } else {
            // TODO: relationテーブルを非表示（または非活性）にする
        }
    }

    /*
    セクションの数を返す.
    */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Keep, Problem, Tryテーブルそれぞれ1セクション固定
        return relationCardTableSections.count
    }
    
    /*
    セクションのタイトルを返す.
    */
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return relationCardTableSections[section]
    }
    
    /*
    Cellが選択された際に呼び出される.
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // TODO: チェックがつけばいいな
    }
    
    /*
    テーブルに表示する配列の総数を返す.
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return keepCardEntities.count
        } else if section == 1 {
            return problemCardEntities.count
        } else {
            return 0
        }
    }
    
    /*
    Cellに値を設定する.
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "\(keepCardEntities[indexPath.row].card_title)"
            cell.detailTextLabel!.text = "\(keepCardEntities[indexPath.row].detail)"
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "\(problemCardEntities[indexPath.row].card_title)"
            cell.detailTextLabel!.text = "\(problemCardEntities[indexPath.row].detail)"
        }
        
        return cell
    }
}
