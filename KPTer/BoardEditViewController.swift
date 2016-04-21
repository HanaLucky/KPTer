//
//  BoardEditViewController.swift
//  KPTer
//
//  Created by yoshikawa atsushi on 2/20/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//

import UIKit
import RealmSwift

class BoardEditViewController: UIViewController {

    @IBOutlet weak var boardTitleField: UITextField!
    
    var board: Board? = nil
    
    // 画面遷移の識別子(ボード一覧のAddから来たかEditからきたか判別)
    var identifier: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // @TODO implements
        if let boardEntity = board {
            self.boardTitleField.text = boardEntity.board_title
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: AnyObject) {
        if (self.identifier == Identifiers.FromAddButtonToBoardEdit.rawValue) {
            BoardViewModel.create(self.boardTitleField.text!)
        } else if (self.identifier == Identifiers.FromEditButtonToBoardEdit.rawValue) {
            let editBoard = Board()
            editBoard.board_title = self.boardTitleField.text!
            BoardViewModel.edit(board!, editBoard: editBoard)            
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel(sender: AnyObject) {
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

}
