//
//  CDDataManager.swift
//  Cached
//
//  Created by Daniel on 3/5/15.
//  Copyright (c) 2015 Daniel Rakhamimov. All rights reserved.
//

import Foundation


public class CDDataManager  {
    
    let networkService = CDNetworkService()
    
    
    public init() {
        
    }
    
    func createStoryItemsForTopStories(count:UInt, completion:(storyItems:[CDStoryItem]) -> Void) {
        
        var tmpStoryItems = [CDStoryItem]()
        
        networkService.fetchTopStories(count, completion: { (stories:[AnyObject]) -> Void in
            
            for (idx, _) in enumerate(stories) {
                
                let storyItem = CDStoryItem(
                    id: (stories[idx]["id"] as! NSNumber).stringValue,
                    title: stories[idx]["title"] as! String,
                    author: stories[idx]["by"] as! String,
                    time: (stories[idx]["time"] as! NSNumber).stringValue,
                    url: stories[idx]["url"] as? String,
                    score: (stories[idx]["score"] as! NSNumber).stringValue,
                    text: stories[idx]["text"] as? String)
                
                tmpStoryItems.append(storyItem)
            }
            
            completion(storyItems: tmpStoryItems)
        })
    }
    
}