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
                let cellModel = CDFeedTableViewCellModel(storyItem: story)
                newStories.append(cellModel)
            }
            
            self.storyCellModels.splice(newStories, atIndex: 0)
            println(self.storyCellModels)
        }
    }
}