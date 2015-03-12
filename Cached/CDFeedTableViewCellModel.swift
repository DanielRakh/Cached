//
//  CDFeedTableViewCellModel.swift
//  Cached
//
//  Created by Daniel on 3/8/15.
//  Copyright (c) 2015 Daniel Rakhamimov. All rights reserved.
//

import Foundation
import Bond

class CDFeedTableViewCellModel {
    
    lazy var fullTitle:Dynamic<NSAttributedString> = {
        
        let attriString = NSAttributedString(string:self.title + " " + "\(self.url!)", attributes:
            [NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 10.0)!])
        return Dynamic(attriString)
    }()
    
//    
//    lazy var commentsAmount:Dynamic<String> = {
//        
//    }()
    
//    let title:Dynamic<String>
    
    let text:Dynamic<String?>
    
    lazy var info:Dynamic<String> = {
        let attriString = NSAttributedString(string:"\(self.score) Pts", attributes:
            [NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 10.0)!])
        let str = String(_cocoaString: attriString)
        return Dynamic(str)
        }()
    
    private let id:String
    private let author:String
    private let time:String
    private let url:String?
    private let score:String
    private let title:String
    
    
    init(storyItem:CDStoryItem) {
        
        self.id = storyItem._id
        self.author = storyItem._author
        self.time = storyItem._time
        self.url = storyItem._url
        self.score = storyItem._score
        self.text = Dynamic(storyItem._text)
        self.title = storyItem._title
    }
}