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
        
        let titleString = NSAttributedString(string: self.title, attributes:[NSFontAttributeName : UIFont(name:"AvenirNext-DemiBold", size: 14.0)!])
        
        let urlString = NSAttributedString(string:" (\(self.url!.pathComponents[1]))", attributes:
            [NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 10.0)!])
        
        let fullString:NSMutableAttributedString = NSMutableAttributedString(attributedString: titleString)
        fullString.appendAttributedString(urlString)
        
        return Dynamic(fullString)
    }()

    
    let text:Dynamic<String?>
    
    lazy var info:Dynamic<NSAttributedString> = {
        
        let scoreString:NSAttributedString = NSAttributedString(string:"\(self.score) Points | ", attributes:
            [NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 10.0)!, NSForegroundColorAttributeName : UIColor.cdOrange()])
        
        let authorString = NSAttributedString(string:" | \(self.author)", attributes:
            [NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 10.0)!])
        
        let timeString = NSAttributedString(string:" | \(self.time)", attributes:
            [NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 10.0)!])
        
        let fullString:NSMutableAttributedString = NSMutableAttributedString(attributedString: scoreString)
        fullString.appendAttributedString(authorString)
        fullString.appendAttributedString(timeString)
        
        return Dynamic(fullString)
        
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
    
    
//    func formatUNIXTimeStamp(unixTime:NSTimeInterval) -> String {
//        
//        let date = NSDate(timeIntervalSinceNow: unixTime)
//        let dateFormatter = NSDateFormatter()
//    }
//    
    
    
}