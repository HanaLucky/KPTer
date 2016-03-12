//
//  CardViewController.swift
//  KPTer
//
//  Created by yoshikawa atsushi on 3/11/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    // card title field
    @IBOutlet weak var titleField: UITextField!
    
    // description field
    @IBOutlet weak var descriptionField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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

}
