//
//  ViewController.swift
//  Cached
//
//  Created by Daniel on 3/1/15.
//  Copyright (c) 2015 Daniel Rakhamimov. All rights reserved.
//

import UIKit
import XCGLogger

public class FeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var storyCollection = [AnyObject]()
    


    public override func viewDidLoad() {
        super.viewDidLoad()
   
        tableView.dataSource = self
        tableView.delegate = self
        

        
        
    }
    
    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

extension FeedViewController : UITableViewDataSource {
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyCollection.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
//        cell.textLabel?.text = (storyCollection[indexPath.row] as CDStoryItem)._title
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
}

extension FeedViewController : UITableViewDelegate {
}

