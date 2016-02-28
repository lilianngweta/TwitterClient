//
//  DetailViewController.swift
//  TwitterClient
//
//  Created by Lilian Ngweta on 2/27/16.
//  Copyright © 2016 Lilian Ngweta. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var timelapseLabel: UILabel!
    
    @IBOutlet weak var favoriteLabel: UILabel!
    
    @IBOutlet weak var retweetLabel: UILabel!
    
    
    
    
    var tweet: Tweet!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
                tweetTextLabel.text = String(tweet.text!)
                timelapseLabel.text = String(tweet.timestamp!)
                favoriteLabel.text = "\(tweet.favoritesCount)"
                retweetLabel.text = "\(tweet.retweetCount)"
                
                if((tweet.user?.profileImageURL)! != nil)
                {
                    profileImageView.setImageWithURL(NSURL(string: (tweet.user?.profileImageURL)!)!)
                }
                
                usernameLabel.text = tweet.user?.name as String?
        
        

        
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
