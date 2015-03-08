//
//  CDWebViewController.swift
//  Cached
//
//  Created by Daniel on 3/6/15.
//  Copyright (c) 2015 Daniel Rakhamimov. All rights reserved.
//

import UIKit

class CDWebViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func closeButtonDidTap(sender: AnyObject) {
        
        presentingViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            //
        })
    }
}
