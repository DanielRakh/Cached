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
    
    public init(){}
    
    
    
    public func fetchTopStories(count:UInt) -> [AnyObject]? {
        
        var stories = [AnyObject]?()
        
        ref.queryLimitedToFirst(count).observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            for child in snapshot.children {
                stories?.append(child)
            }
            
            }){ error in
                println("There was an error")
        }
        println("STORIES:\(stories?.count)")
        return stories
    }
    
    
}