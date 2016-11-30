//
//  FetchManager.swift
//  BeaconBuisness
//
//  Created by Buwaneka Galpoththawela on 9/9/16.
//  Copyright © 2016 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit
import CoreData

class FetchManager: NSObject {
    
    static let sharedInstance = FetchManager()
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext : NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    //Fetch Cities Method
    
    func fetchCityNames(keyString: String) -> [Cities]? {
        
        let fetchRequest : NSFetchRequest = NSFetchRequest(entityName: "Cities")
        fetchRequest.sortDescriptors = [NSSortDescriptor (key: keyString, ascending: true)]
        do {
              let tempArray = try managedObjectContext!.executeFetchRequest(fetchRequest)
                as! [Cities]
     
            return tempArray
            
         }catch {
            return nil
      }
        
  }
    
    // Fetch Busines Types
    
    func fetchBusinessTypes(keyString: String) -> [BusinessType]? {
        
        let fetchRequest : NSFetchRequest = NSFetchRequest(entityName: "BusinessType")
        fetchRequest.sortDescriptors = [NSSortDescriptor (key: keyString, ascending: true)]
        do {
            let tempArray = try managedObjectContext!.executeFetchRequest(fetchRequest)
                as! [BusinessType]
            
            return tempArray
        }catch {
            return nil
     }
        
  }
    

    func removeAllRequests() {
        if let toDeleteArray = fetchCityNames("name"){
            for request in toDeleteArray {
                managedObjectContext.deleteObject(request)
            }
               appDelegate.saveContext()
        }
    }

    func clearAllBusinessTypes() {
        if let toDeleteArray = fetchBusinessTypes("type"){
            for request in toDeleteArray {
                managedObjectContext.deleteObject(request)
            }
               appDelegate.saveContext()
        }
   }

    
    

}
