//
//  ViewController.swift
//  Cached
//
//  Created by Daniel on 3/1/15.
//  Copyright (c) 2015 Daniel Rakhamimov. All rights reserved.
//

import UIKit
import Bond

public class CDFeedController: UIViewController {
    
    @IBOutlet weak var tableView: CDFeedTableView!
    
    var feedViewModel = CDFeedControllerModel()
    var tableViewDataSourceBond:UITableViewDataSourceBond<UITableViewCell>!
    var refreshView:DRRefreshView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
   
        view.backgroundColor = UIColor.cdOffWhite()
        
        setupTableView()
        setupTableViewModel()
        setupRefreshView()
        
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        feedViewModel.fetchTopStories(30)
    }
    
    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        tableView.delegate = self
        refreshView.lowerScrollLimit = tableView.contentInset.top
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .None
        tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 90
        
        tableView.registerClass(CDFeedTableViewCell.self, forCellReuseIdentifier: "CardCell")
        
    }
    
    
    private func setupTableViewModel() {
        tableViewDataSourceBond = UITableViewDataSourceBond(tableView: self.tableView)
        
        feedViewModel.storyCellModels.map {
            [unowned self] (viewModel:CDFeedTableViewCellModel) -> CDFeedTableViewCell in
            
            let cell = (self.tableView.dequeueReusableCellWithIdentifier("CardCell") as? CDFeedTableViewCell)!
            
            viewModel.fullTitle ->> cell.titleLabel.dynAttributedText
            viewModel.info ->> cell.infoLabel.dynAttributedText
            viewModel.commentsCount ->> cell.commentsButton.dynTitle
            
            
            cell.setNeedsUpdateConstraints()
            cell.updateConstraintsIfNeeded()
            return cell
            } ->> tableViewDataSourceBond
        
    }
    
    private func setupRefreshView() {
        
        refreshView = DRRefreshView(frame: CGRect(origin: CGPoint(x: 0, y: -view.bounds.height), size: CGSize(width: view.bounds.width, height: view.bounds.height)), scrollView: tableView)
        refreshView.setTranslatesAutoresizingMaskIntoConstraints(false)
        refreshView.delegate = self
        tableView.addSubview(refreshView)
        tableView.insertSubview(refreshView, atIndex: 0)
    }
    
    private func delayBySeconds(seconds:Double, delayedCode:()->()) {
        
        let targetTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * seconds))
        
        dispatch_after(targetTime, dispatch_get_main_queue()) {
            delayedCode()
        }
    }
    
}

extension CDFeedController : DRRefreshViewDelegate {
    
    func refreshViewDidRefresh(refreshView:DRRefreshView) {
        
//        feedViewModel.fetchTopStories(50)

        
        delayBySeconds(3, delayedCode: { () -> () in
            refreshView.endRefreshing()
        })
    }
}


extension CDFeedController : UITableViewDelegate {
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        refreshView.scrollViewDidScroll(scrollView)
    }
    
    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        refreshView.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("PresentWebViewController", sender: self)
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
*/




//