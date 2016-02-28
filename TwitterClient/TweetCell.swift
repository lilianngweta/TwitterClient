//
//  TweetCell.swift
//  TwitterClient
//
//  Created by Lilian Ngweta on 2/27/16.
//  Copyright © 2016 Lilian Ngweta. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var timelapseLabel: UILabel!
    
    @IBOutlet weak var favoriteLabel: UILabel!
    
    @IBOutlet weak var retweetLabel: UILabel!
    

    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = String(tweet.text!)
            timelapseLabel.text = String(tweet.timestamp!)
            favoriteLabel.text = "\(tweet.favoritesCount)"
            retweetLabel.text = "\(tweet.retweetCount)"
            
            if((tweet.user?.profileImageURL)! != nil)
            {
                profileImageView.setImageWithURL(NSURL(string: (tweet.user?.profileImageURL)!)!)
            }
            
            usernameLabel.text = tweet.user?.name as String?
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
