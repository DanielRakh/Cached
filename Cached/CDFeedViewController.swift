//
//  ViewController.swift
//  Cached
//
//  Created by Daniel on 3/1/15.
//  Copyright (c) 2015 Daniel Rakhamimov. All rights reserved.
//

import UIKit
import XCGLogger

public class CDFeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let dataManager = CDDataManager()
    
    var storyCollection = [CDStoryItem]()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
   
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .None
        tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0)
        
        view.backgroundColor = UIColor.cdOffWhite()
        
        dataManager.createStoryItemsForTopStories(20) {
            storyItems in
            self.storyCollection = storyItems
            self.tableView.reloadData()
        }
        
    }
    
    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

extension CDFeedViewController : UITableViewDataSource {
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyCollection.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = (storyCollection[indexPath.row])._title
        return cell
    }
    
}

extension CDFeedViewController : UITableViewDelegate {
}

