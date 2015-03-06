//
//  CDNetworkService.swift
//  Cached
//
//  Created by Daniel on 3/4/15.
//  Copyright (c) 2015 Daniel Rakhamimov. All rights reserved.
//

import Foundation


public class CDNetworkService {
    
    var ref = Firebase(url: "https://hacker-news.firebaseio.com/v0/topstories")
    
    public init(){
        
    }
    
    
    public func fetchTopStories(count:UInt, completion:(stories:[AnyObject]) -> Void) {
        
        var stories = [AnyObject]()
        
        ref.queryLimitedToFirst(count).observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            var childArray = [AnyObject]()
            
            for child in snapshot.children {
                let itemRef =  Firebase(url:"https://hacker-news.firebaseio.com/v0/item/")
                    .childByAppendingPath("\((child as! FDataSnapshot).value)")
                
                itemRef.observeSingleEventOfType(.Value, withBlock: { child in
                    childArray.append(child.value)
                    if childArray.count == Int(count) {
                        completion(stories: childArray)
                    }
                })
                
            }
            
            }){ error in
                println("There was an error")
        }
        
    }
    
}