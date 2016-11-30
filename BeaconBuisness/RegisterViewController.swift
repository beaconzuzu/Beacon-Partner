//
//  RegisterViewController.swift
//  BeaconBuisness
//
//  Created by Buwaneka Galpoththawela on 7/5/16.
//  Copyright © 2016 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var businessNameTextField: UITextField!
    @IBOutlet weak var businessTypeTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var businessTypePickerView: UIPickerView!
    @IBOutlet weak var cityNamePickerView: UIPickerView!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    
    
    var backendless = Backendless.sharedInstance()
    let businesses =  Businesses()
    var fetchManager = FetchManager()
    var cityNamesArray = [Cities]()
    var businessTypeArray = [BusinessType]()
    
    
    
    //MARK: -  Picker View delegates and data sources
    
    //MARK: Data Sources
    // Builds pickerview components and rows
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
          if pickerView == businessTypePickerView {
            return 1
        } else if pickerView == cityNamePickerView {
            return 1
        }
      return 0
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
          if pickerView == businessTypePickerView{
            return businessTypeArray.count
        }else if pickerView == cityNamePickerView{
            return cityNamesArray.count
      }
        return 0
    }
    
    
    
    //MARK: Delegate
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?      {
          if pickerView == businessTypePickerView{
            return businessTypeArray[row].type
        }else if pickerView == cityNamePickerView{
            return cityNamesArray[row].name
      }
           return cityNamesArray[row].name
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          if pickerView == businessTypePickerView{
             businessTypeTextField.text = businessTypeArray[row].type
        }else if pickerView == cityNamePickerView{
             cityNameLabel.text = cityNamesArray[row].name
      }
    }

    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if pickerView == businessTypePickerView{
            let titleData = businessTypeArray[row].type
            let myTitle = NSAttributedString(string:titleData!,attributes:[NSFontAttributeName:UIFont(name:"Avenir Next",size: 15.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
            return myTitle
        }else{
            if pickerView == cityNamePickerView{
                let titleData = cityNamesArray[row].name
                let myTitle = NSAttributedString(string:titleData!,attributes:[NSFontAttributeName:UIFont(name:"Avenir Next",size: 15.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
                return myTitle
                
            }
            
        }
        let titleData = cityNamesArray[row].name
        let myTitle = NSAttributedString(string:titleData!,attributes:[NSFontAttributeName:UIFont(name:"Avenir Next Regular",size: 15.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
        return myTitle
        
        
    }
    
    //MARK: Interactive Method
    
    
    
    @IBAction func registerButtonPressed(_ sender:UIButton){
        
        businesses.name = businessNameTextField.text
        businesses.type = businessTypeTextField.text
        businesses.city = cityNameLabel.text
        businesses.phoneNumber = phoneNumberTextField.text
        businesses.email = emailTextField.text 
        
        let dataStore = backendless.data.of(Businesses.ofClass())
        
        // save object synchronously
        var error: Fault?
        let savedBusiness = dataStore.save(businesses, fault: &error) as? Businesses
          if error == nil {
            print("Business has been saved: \(savedBusiness!.name)")
        }
          else {
            print("Server reported an error: \(error)")
        }
        
        let userEmail = emailTextField.text
        let userPassword = passwordTextField.text
        let userPhoneNumber = phoneNumberTextField.text
        let userBusinessName = businessNameTextField.text
        let userBusinessType = businessTypeTextField.text
        //let userRepeatPassword = repeatPasswordTextField.text
        
        if (userEmail!.isEmpty || userPassword!.isEmpty || userPhoneNumber!.isEmpty || userBusinessName!.isEmpty || userBusinessType!.isEmpty) {
            
            displayAlertMessage("All fields are required")
        }
        
            let user = BackendlessUser()
                user.email = userEmail
                user.password = userPassword
        
     backendless.userService.registering(user,response: { ( registeredUser : BackendlessUser!) -> () in
          print("User has been registered (ASYNC): \(registeredUser)")
       
            self.displayAlertMessage("Registration was succesful,Thank you")
            self.dismissViewControllerAnimated(true, completion: nil)
        
    },error: { ( fault : Fault!) -> () in
        
         print("Server reported an error: \(fault)")
            self.displayAlertMessage("\(fault.detail)")
                                                
      }
  
   )
        
 }
    
    
    @IBAction func alreadyRegisteredUserButtonPressed(_ sender:UIButton){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Display "ALERT" messages
    
    
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
        
        businessTypePickerView.delegate = self
        businessTypePickerView.dataSource = self
        
        cityNamePickerView.delegate = self
        cityNamePickerView.dataSource = self
        
        cityNamesArray = fetchManager.fetchCityNames("name")!
        businessTypeArray = fetchManager.fetchBusinessTypes("type")!
        
        //Setting pickerView first value
        
        let businessStartValue = businessTypeArray.last
        let cityStartValue = cityNamesArray.last
        
        businessTypeArray.insert(businessStartValue!, atIndex: 0)
        cityNamesArray.insert(cityStartValue!, atIndex: 0)

        
        cityNameLabel.hidden = true
        businessTypeTextField.hidden = true
      
        //print("\(cityNamesArray)")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
