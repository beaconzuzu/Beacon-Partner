//
//  MessageComposer.swift
//  BeaconUser
//
//  Created by Buwaneka Galpoththawela on 9/13/16.
//  Copyright © 2016 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit
import MessageUI

class MessageComposer: NSObject,MFMessageComposeViewControllerDelegate{
    
    static let sharedInstance = MessageComposer()
    
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
        
    }
    
    
    func configuredMessageComposeViewController(recipient:String!) -> MFMessageComposeViewController {
        
        let textMessageRecipients = recipient
        
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self
        messageComposeVC.recipients = [textMessageRecipients]
        messageComposeVC.body = ""
        return messageComposeVC
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }


}
