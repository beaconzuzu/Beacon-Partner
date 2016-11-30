//
//  DataManager.swift
//  BeaconBuisness
//
//  Created by Buwaneka Galpoththawela on 9/9/16.
//  Copyright © 2016 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit
import CoreData

class DataManager: NSObject {
    
    static let sharedInstance = DataManager()
    var backendless = Backendless.sharedInstance()
    var fetchManager = FetchManager()
    
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext : NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    
    // Fetch City names from Backendless
    
    
    func findCitiesSync() {
        
        fetchManager.removeAllRequests()
        
        let dataStore = backendless.data.of(Cities.ofClass())
        var error: Fault?
        
        let result = dataStore.findFault(&error)
        if error == nil {
            
            let cities = result.getCurrentPage()
                print("\(cities.count)")
            
            for city in cities {
                
                let entityDescription :NSEntityDescription! = NSEntityDescription.entityForName("Cities", inManagedObjectContext: managedObjectContext)
               
                let currentCityName:Cities! = Cities(entity:entityDescription,insertIntoManagedObjectContext:managedObjectContext)
                
                   currentCityName.name = city.valueForKey("Name") as? String
                   appDelegate.saveContext()
                
                let name = city.valueForKey("Name") as! String
                    print("\(name)")
        }
    }
         else {
            print("Server reported an error: \(error)")
       }
}

    
    func findBusinessTypesSync() {
        
        fetchManager.clearAllBusinessTypes()
        
        let dataStore = backendless.data.of(BusinessType.ofClass())
        var error: Fault?
        
        let result = dataStore.findFault(&error)
        if error == nil {
            
            
            let businessTypes = result.getCurrentPage()
                print("\(businessTypes.count)")
            
            for businessType in businessTypes {
                
                let entityDescription :NSEntityDescription! = NSEntityDescription.entityForName("BusinessType", inManagedObjectContext: managedObjectContext)
                
                let currentBusinessType:BusinessType! = BusinessType(entity:entityDescription,insertIntoManagedObjectContext:managedObjectContext)
                
                    currentBusinessType.type = businessType.valueForKey("Type") as? String
                    appDelegate.saveContext()
                
                let name = businessType.valueForKey("Type") as! String
                    print("\(name)")
            }
      }
          else {
            print("Server reported an error: \(error)")
        }
 }


}
