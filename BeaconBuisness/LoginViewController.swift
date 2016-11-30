//
//  LoginViewController.swift
//  BeaconBuisness
//
//  Created by Buwaneka Galpoththawela on 7/5/16.
//  Copyright © 2016 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField:UITextField!
    @IBOutlet weak var passwordTextField:UITextField!
    
    var backendless = Backendless.sharedInstance()
   
    var dataManager = DataManager()
    
    
    
    @IBAction func loginButtonTapped(_ sender:AnyObject){
        
        let userEmail = emailTextField.text
        let userPassword = passwordTextField.text
        
        
        backendless.userService.login(userEmail, password:userPassword,response: { ( registeredUser :BackendlessUser!) -> () in
            
              print("User has been logged in (ASYNC): \(registeredUser)")
               // self.dismissViewControllerAnimated(true, completion: nil)
            
                self.backendless.userService.setStayLoggedIn(true)
                self.performSegueWithIdentifier("loggedInView", sender: self)
        },
               error: { ( fault : Fault!) -> () in
               print("Server reported an error: \(fault)")
               self.displayAlertMessage("\(fault.detail)")
            }
        )
        
        
    }
    
    
    func validUserToken() {
        backendless.userService.isValidUserToken(
            { ( result : AnyObject!) -> () in
                print("isValidUserToken (ASYNC): \(result.boolValue)")
                self.backendless.userService.setStayLoggedIn(true)
                self.performSegueWithIdentifier("loggedInView", sender: nil)
            },
            error: { ( fault : Fault!) -> () in
                print("Server reported an error (ASYNC): \(fault)")
            }
        )
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

    
    
    //MARK : Life Cycle Method

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.validUserToken()
        
        dataManager.findCitiesSync()
        dataManager.findBusinessTypesSync()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
