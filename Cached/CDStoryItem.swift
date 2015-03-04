//
//  CDStoryItem.swift
//  Cached
//
//  Created by Daniel on 3/4/15.
//  Copyright (c) 2015 Daniel Rakhamimov. All rights reserved.
//

import Foundation


public struct CDStoryItem {
    
    public let _id:String
    public let _title:String
    public let _url:String
    public let _text:String
    
    public init(id:String, title:String, url:String, text:String) {
        _id = id
        _title = title
        _url = url
        _text = text
    }
}
