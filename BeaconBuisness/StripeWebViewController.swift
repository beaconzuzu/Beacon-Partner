//
//  StripeWebViewController.swift
//  BeaconBuisness
//
//  Created by Buwaneka Galpoththawela on 10/25/16.
//  Copyright © 2016 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit

class StripeWebViewController: UIViewController{
    
    
    @IBOutlet weak var stripeWebView: UIWebView!
    
   
    
    
    
    //MARK: Life Cycle Method

    override func viewDidLoad() {
        super.viewDidLoad()

        stripeWebView.loadRequest(NSURLRequest(URL: NSURL(string: "http://www.stripe.com")!))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
