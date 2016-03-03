//
//  ReplyViewController.swift
//  TwitterClient
//
//  Created by Lilian Ngweta on 3/2/16.
//  Copyright © 2016 Lilian Ngweta. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {
    
    var username: String?
    var id: Int = 0
    
    @IBAction func onReplyButton(sender: AnyObject) {
        
        TwitterClient.sharedInstance.reply(replyView.text, id: id)
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBOutlet weak var replyView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        replyView.text = "@" + username!

        // Do any additional setup after loading the view.
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

}
