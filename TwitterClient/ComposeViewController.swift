//
//  ComposeViewController.swift
//  TwitterClient
//
//  Created by Lilian Ngweta on 2/27/16.
//  Copyright © 2016 Lilian Ngweta. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    
    @IBAction func onTweetButton(sender: AnyObject) {
        
        TwitterClient.sharedInstance.compose(composeView.text)
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBOutlet weak var composeView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TwitterClient.sharedInstance.compose(composeView.text)

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
