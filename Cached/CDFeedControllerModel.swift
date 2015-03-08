//
//  CDFeedTableControllerModel.swift
//  Cached
//
//  Created by Daniel on 3/8/15.
//  Copyright (c) 2015 Daniel Rakhamimov. All rights reserved.
//

import Foundation
import Bond

class CDFeedControllerModel {
    
    let storyCellModels:DynamicArray<CDFeedTableViewCellModel>
    let dataManager = CDDataManager()
    
    
    init() {
        storyCellModels = DynamicArray([])
    }
    
    func fetchTopStories(count:UInt) {
        
        var newStories = [CDFeedTableViewCellModel]()
        
        dataManager.createStoryItemsForTopStories(count) {
            storyItems in
            for story in storyItems {
                
                let cellModel = CDFeedTableViewCellModel(id: story._id,
                    title: story._title,
                    author: story._author,
                    time: story._time,
                    url: story._url,
                    score: story._score,
                    text: story._text)
                
                newStories.append(cellModel)
            }
            
            self.storyCellModels.splice(newStories.reverse(), atIndex: 0)
        }
    }
}