//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Ricardo Canales on 7/28/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // allows to access coredata
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        // add new user
//        let newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context)
        
//        newUser.setValue("Kake", forKey: "username")
//        newUser.setValue("kespas", forKey: "password")
//        
//        do {
//            try context.save()
//        } catch {
//            print("there was a problem")
//        }
        
        let request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        // queries
//        request.predicate = NSPredicate(format: "username = %@", "Ricardo")
        
        do {
            let results = try context.executeFetchRequest(request)
            if results.count > 0 {
                for result: AnyObject in results {
                    // get data
                    if let username: String = result.valueForKey("username") as? String {
                        print(username)
                        
                        // updating value
                        // result.setValue("kakeke", forKey: "username")
                        
                        // deleting object
//                        context.deleteObject(result as! NSManagedObject)
                        
                        do { try context.save() }
                        catch { print("error updating") }
                    }
                    
                    

                }
                
                
//                for result in results as! [NSManagedObject] {
//                    print(result.valueForKey("username")!)
//                    print(result.valueForKey("password")!)
//                }
            }

        } catch {
            print("catch failed")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

