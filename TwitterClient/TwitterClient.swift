//
//  TwitterClient.swift
//  TwitterClient
//
//  Created by Lilian Ngweta on 2/23/16.
//  Copyright © 2016 Lilian Ngweta. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "G7ExVbiolRHsEADmsQBzBtAHx", consumerSecret: "MMFTiQaw6egLGnZWcdRFZZpUENy9LyZ1umShEkaCJmKEieCG4Q")
    
    var loginSuccess: (()->())?
    var loginFailure: ((NSError)->())?
    
    
    func login(success: ()->(), failure: (NSError)->()) {
        
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "mytwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            }) { (error: NSError!) -> Void in
                print ("error: \(error.localizedDescription)")
                self.loginFailure?(error)
                
        }
    }
    
    
    func logout() {
        
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
     
    }
    
    
    func handleOpenUrl(url: NSURL) {
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
           
            self.currentAccount({ (user: User) -> () in
               
                User.currentUser = user
                self.loginSuccess?()
                
                }, failure: { (error: NSError) -> () in
                
                    self.loginFailure?(error)
            })
            
            self.loginSuccess?()
            
        }) { (error: NSError!) -> Void in
                print("error:\(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    
    func homeTimeLine(success: ([Tweet]) -> (), failure: (NSError) -> ()){
        
            GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response:AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
               success(tweets)
            
            }, failure: { (TASK: NSURLSessionDataTask?, error: NSError) -> Void in
            
               failure(error)
                
        })
        
        }
    
    
    
    func userTimeLine(success: ([Tweet]) -> (), failure: (NSError) -> ()){
        
        GET("1.1/statuses/user_timeline.json?screen_name=Liliangweta", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response:AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            
            }, failure: { (TASK: NSURLSessionDataTask?, error: NSError) -> Void in
                
                failure(error)
                
        })
        
    }

    
    func currentAccount(success: (User)->(), failure: (NSError)->()){
        
        
            GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            // print("account:\(response)")
            
            let userDictionary = response as? NSDictionary
            let user = User(dictionary: userDictionary! )
                
                
            success(user)
            
            
        }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            
            failure(error)
        })
        
    }

    func compose(text: String ){
        
        
        POST("1.1/statuses/update.json", parameters: ["status": text], success:{
            (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            
        },
        
            failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                
            })
        
    }
    
    
    func reply(text: String, id: Int ){
        
        
        POST("1.1/statuses/update.json", parameters: ["status": text, "in_reply_to_status_id": id], success:{
            (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            
            },
            
            failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                
        })
        
    }
    
    func favorite(id: Int) {
        POST("1.1/favorites/create.json", parameters: ["id": id],
            success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                print("favorited tweet: \(id)")
            },
            failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("failed to favorite")
                print(error)
            }
        )
    }
    func retweet(id: Int) {
        POST("1.1/statuses/retweet/\(id).json", parameters: ["id": id],
            success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                print("retweeted tweet: \(id)")
            },
            failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("failed to retweet")
                print(error)
            }
        )
    }

    
    
}
