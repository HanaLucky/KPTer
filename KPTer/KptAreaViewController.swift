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
//        BoardViewModel.addCard(self.board!, title: "keep card1", detail: "keep detail1", type: Card.CardType.Keep)
//        BoardViewModel.addCard(self.board!, title: "keep card2", detail: "keep detail2", type: Card.CardType.Keep)
//        BoardViewModel.addCard(self.board!, title: "keep card3", detail: "keep detail3", type: Card.CardType.Keep)
//        
//        BoardViewModel.addCard(self.board!, title: "problem card1", detail: "problem detail2", type: Card.CardType.Problem)
//        BoardViewModel.addCard(self.board!, title: "problem card2", detail: "problem detail3", type: Card.CardType.Problem)
//        
//        BoardViewModel.addCard(self.board!, title: "try card1", detail: "try detail1", type: Card.CardType.Try)
//        BoardViewModel.addCard(self.board!, title: "try card2", detail: "try detail2", type: Card.CardType.Try)
//        BoardViewModel.addCard(self.board!, title: "try card3", detail: "try detail3", type: Card.CardType.Try)
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == TableViewTags.keepTableViewTag.rawValue {
            return keepCardEntities.count
        } else if tableView.tag == TableViewTags.problemTableViewTag.rawValue {
            return problemCardEntities.count
        } else if tableView.tag == TableViewTags.tryTableViewTag.rawValue {
            return tryCardEntities.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell? = nil
        
        if tableView.tag == TableViewTags.keepTableViewTag.rawValue {
            cell = tableView.dequeueReusableCellWithIdentifier("KeepCard") as! KeepCardTableViewCell
            cell!.textLabel!.text = keepCardEntities[indexPath.row].card_title
        } else if tableView.tag == TableViewTags.problemTableViewTag.rawValue {
            cell = tableView.dequeueReusableCellWithIdentifier("ProblemCard") as! ProblemCardTableViewCell
            cell!.textLabel!.text = problemCardEntities[indexPath.row].card_title
        } else if tableView.tag == TableViewTags.tryTableViewTag.rawValue {
            cell = tableView.dequeueReusableCellWithIdentifier("TryCard") as! TryCardTableViewCell
            cell!.textLabel!.text = tryCardEntities[indexPath.row].card_title
        }
        
        return cell!
    }
}
