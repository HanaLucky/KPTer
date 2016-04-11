//
//  CardViewController.swift
//  KPTer
//
//  Created by yoshikawa atsushi on 3/11/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//

import UIKit
import RealmSwift

class CardViewController: UIViewController {

    @IBOutlet weak var typeSegment: UISegmentedControl!
    // card title field
    @IBOutlet weak var titleField: UITextField!
    // description field
    @IBOutlet weak var descriptionField: UITextView!
    // KPTエリアから受け取るボード
    var board: Board? = nil
    // KPTエリアから受け取るカード
    var card: Card? = nil
    // 画面遷移の識別子(ボード一覧のAddから来たかEditからきたか判別)
    var identifier: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        // カードエンティティが渡ってきたら（基本、編集時のみ）
        if let cardEntity = card {
            typeSegment.selectedSegmentIndex = self.getSegmentIndexOfCardType(cardEntity)
            titleField.text = cardEntity.card_title
            descriptionField.text = cardEntity.detail
        }
        
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
    カードタイプと紐づくセグメントindexを取得する
    
    - parameter card: カードエンティティ
    
    - returns: カードタイプのセグメントindex
    */
    private func getSegmentIndexOfCardType (card: Card) -> Int {
        switch card.type {
        case Card.CardType.Keep.rawValue:
            return 0
        case Card.CardType.Problem.rawValue:
            return 1
        case Card.CardType.Try.rawValue:
            return 2
        default:
            return 0
            // FIXME: 想定外のタイプである場合例外処理とする
            // throw NSError(domain: "illegal card type. card type is [" + card.type + "]", code: -1, userInfo: nil)
        }
    }

}
