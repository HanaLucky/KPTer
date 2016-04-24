//
//  BoardEditViewController.swift
//  KPTer
//
//  Created by yoshikawa atsushi on 2/20/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//

import UIKit
import RealmSwift

class BoardEditViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var boardTitleField: UITextField!
    
    var board: Board? = nil
    
    @IBOutlet weak var save: UIBarButtonItem!
    
    // 画面遷移の識別子(ボード一覧のAddから来たかEditからきたか判別)
    var identifier: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // selfをデリゲートにする
        self.boardTitleField.delegate = self
        
        // Do any additional setup after loading the view.
        // @TODO implements
        if let boardEntity = board {
            self.boardTitleField.text = boardEntity.board_title
        }
        
        // saveボタン非活性
        if (boardTitleField.text! == "") {
            save.enabled = false
        }
    }
    
    // UITextFieldが編集されると呼ばれるデリゲートメソッド
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var textLength: Int;
        textLength = ( textField.text!.characters.count - range.length ) + string.characters.count;
        if (textLength != 0) {
            save.enabled = true
        } else {
            save.enabled = false
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: AnyObject) {
        if (Identifiers.isBoardAdd(self.identifier)) {
            BoardViewModel.create(self.boardTitleField.text!)
        } else if (Identifiers.isBoardEdit(self.identifier)) {
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
