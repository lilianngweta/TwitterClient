 //
//  TweetsViewController.swift
//  TwitterClient
//
//  Created by Lilian Ngweta on 2/23/16.
//  Copyright © 2016 Lilian Ngweta. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    

     var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.estimatedRowHeight = 120
        //stableView.rowHeight = UITableViewAutomaticDimension
        
        TwitterClient.sharedInstance.homeTimeLine({ (tweets:[Tweet]) -> () in
            
            self.tweets = tweets
            self.tableView.reloadData()
            
            
            
            for tweet in tweets {
                //print(tweet.user?.profileImageURL)
                print(tweet.id)
            }
            }) { (error:NSError) -> () in
                print(error.localizedDescription)
        }
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
        
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if let tweets = tweets{
            return tweets.count
            
        }else {
            return 0;
        }
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = tweets![indexPath.row]
        
       // print("row\(indexPath.row)")
        return cell
    }

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "detail")
        {
        let cell = sender as! TweetCell
        let indexPath = tableView.indexPathForCell(cell)
        let tweet = tweets![indexPath!.row]
        
        let detailViewController = segue.destinationViewController as! DetailViewController
        detailViewController.tweet = tweet
        }
        
        else if(segue.identifier == "profile"){
            
            print("profile")
            
        }
        
        else if(segue.identifier == "compose")
        {
            print("compose")
            
        }
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        
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
