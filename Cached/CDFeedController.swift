//
//  ViewController.swift
//  Cached
//
//  Created by Daniel on 3/1/15.
//  Copyright (c) 2015 Daniel Rakhamimov. All rights reserved.
//

import UIKit
import XCGLogger
import Bond

public class CDFeedController: UIViewController {
    
    @IBOutlet weak var tableView: CDFeedTableView!
    
    var feedViewModel = CDFeedControllerModel()
    var tableViewDataSourceBond:UITableViewDataSourceBond<UITableViewCell>!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
   
        tableView.separatorStyle = .None
        tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 90

        tableView.registerClass(CDFeedTableViewCell.self, forCellReuseIdentifier: "CardCell")
        
        view.backgroundColor = UIColor.cdOffWhite()
        
        tableViewDataSourceBond = UITableViewDataSourceBond(tableView: self.tableView)
        
        feedViewModel.storyCellModels.map {
            [unowned self] (viewModel:CDFeedTableViewCellModel) -> CDFeedTableViewCell in
            
            let cell = (self.tableView.dequeueReusableCellWithIdentifier("CardCell") as? CDFeedTableViewCell)!

            viewModel.fullTitle ->> cell.titleLabel.dynAttributedText
            
            
            cell.setNeedsUpdateConstraints()
            cell.updateConstraintsIfNeeded()
            return cell
        } ->> tableViewDataSourceBond
        

    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        feedViewModel.fetchTopStories(50)
    }
    
    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
}

/*
extension CDFeedController : UITableViewDataSource {
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyCollection.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CDFeedTableViewCell
        cell.titleLabel.text = (storyCollection[indexPath.row])._title
        return cell
    }
    
}

extension CDFeedController : UITableViewDelegate {
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("PresentWebViewController", sender: self)
    }
}
*/

//