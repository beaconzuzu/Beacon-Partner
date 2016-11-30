//
//  DisplayViewController.swift
//  BeaconBuisness
//
//  Created by Buwaneka Galpoththawela on 7/6/16.
//  Copyright © 2016 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {
    
    var backendless = Backendless.sharedInstance()
    
    let messageComposer = MessageComposer()
    
    
    
    @IBAction func sendTextMessageButtonTapped(_ sender: UIButton) {
        
        if (messageComposer.canSendText()) {
            let messageComposeVC = messageComposer.configuredMessageComposeViewController("")
            presentViewController(messageComposeVC, animated: true, completion: nil)
        } else {
            
            _ = UIAlertController(title: "Cannot Send Text Message", message: "Your device is not able to send text messages", preferredStyle: .ActionSheet)
            // errorAlert.show()
        }
    }

    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem){
       
        Types.tryblock({ () -> Void in
            self.backendless.userService.logout()
            print("User logged out")
            self.dismissViewControllerAnimated(true, completion: nil)
            },
                       
                       catchblock: { (exception) -> Void in
                        print("Server reported an error: \(exception as! Fault)")
            }
        )
        
    }
    
    
    
    //MARK: Life Cycle Method

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
