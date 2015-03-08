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
    
    let id: Dynamic<String>
    let title: Dynamic<String?>
    let author: Dynamic<String?>
    let time: Dynamic<String?>
    let url: Dynamic<String?>
    let score: Dynamic<String?>
    let text: Dynamic<String?>

    
    init(id:String, title:String?, author:String?, time:String?, url:String?, score:String?, text:String?) {
        
        self.id = Dynamic(id)
        self.title = Dynamic(title)
        self.author = Dynamic(author)
        self.time = Dynamic(time)
        self.url = Dynamic(url)
        self.score = Dynamic(score)
        self.text = Dynamic(text)
        
    }
}