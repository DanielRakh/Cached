//
//  ViewController.swift
//  Cached
//
//  Created by Daniel on 3/1/15.
//  Copyright (c) 2015 Daniel Rakhamimov. All rights reserved.
//

import UIKit

public class FeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
    }


}

extension FeedViewController : UITableViewDataSource {
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20 
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
}

extension FeedViewController : UITableViewDelegate {
}

