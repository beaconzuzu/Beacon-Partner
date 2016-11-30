//
//  ResetPasswordViewController.swift
//  BeaconBuisness
//
//  Created by Buwaneka Galpoththawela on 10/5/16.
//  Copyright © 2016 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    var backendless = Backendless.sharedInstance()
    
    func userPasswordRecoveryAsync(email:String) { backendless.userService.restorePassword( email,
          response:{ ( result : AnyObject!) -> () in
              print("Check your email address! result = \(result)")
            },
              error: { ( fault : Fault!) -> () in
              print("Server reported an error: \(fault)")
          }
       )
    }
    
    @IBAction func submitButtonPressed(_ sender:UIButton){
        let emailField = emailTextField.text!
        
          if(emailField.isEmpty){
            self.displayAlertMessage("Email field is empty")
            
         }else{
            userPasswordRecoveryAsync(emailField)
            self.dismissViewControllerAnimated(true, completion: nil)
      }
        
    }
    
    @IBAction func exitButtonPressed(_ sender:UIButton){
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
   
    
    // Display "Alert" messages
    
    func displayAlertMessage(userMessage:String){
        
        let myAlert = UIAlertController(title:"Alert",message: userMessage,preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok",style: UIAlertActionStyle.Default,handler: nil)
        
        myAlert.addAction(okAction)
        self.presentViewController(myAlert,animated: true,completion: nil)
    }

    
    // Dismiss keyboard by touching anywhere on the view
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        super.touchesBegan(touches, withEvent:event)
        self.view.endEditing(true)
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
