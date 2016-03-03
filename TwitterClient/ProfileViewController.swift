//
//  ProfileViewController.swift
//  TwitterClient
//
//  Created by Lilian Ngweta on 2/27/16.
//  Copyright © 2016 Lilian Ngweta. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var numTweets: UILabel!
    
    @IBOutlet weak var numFollowers: UILabel!
   
    @IBOutlet weak var numFollowing: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    //@IBOutlet weak var profileBackgroundImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var screennameLabel: UILabel!
    

    var tweets: [Tweet]!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.estimatedRowHeight = 120
        //tableView.rowHeight = UITableViewAutomaticDimension
        
        TwitterClient.sharedInstance.userTimeLine({ (tweets:[Tweet]) -> () in
            
            self.tweets = tweets
            self.tableView.reloadData()
            
            
            
            for tweet in tweets {
                print(tweet.user?.profileImageURL)
            }
            
            
            
            }) { (error:NSError) -> () in
                print(error.localizedDescription)
        }
        
        /*
        
        //self.numTweets.text = String(self.user!.profileTweets!)
        self.numFollowing.text = String(self.user?.profileFollowing)
        self.numFollowers.text = String(self.user?.profileFollowers!)
        self.screennameLabel.text = "@" + String(self.user?.screenname!)
        self.usernameLabel.text = String(self.user?.name!)
        //self.profileBackgroundImageView.setImageWithURL(NSURL(string: self.user!.profileImageURL!)!)
        //self.profileImageView.setImageWithURL(NSURL(string: self.user!.profileImageBackgroundURL!)!)
        self.tableView.reloadData()
        
        
        // Do any additional setup after loading the view.
        
        
        */
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
