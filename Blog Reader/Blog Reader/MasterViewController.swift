//
//  MasterViewController.swift
//  Blog Reader
//
//  Created by Ricardo Canales on 7/31/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit
import CoreData

var activeItem:String = ""

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil

    var appDel: AppDelegate! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refreshScreen:")
        self.navigationItem.rightBarButtonItem = refreshButton
        
        appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        
        requestBlogPosts(appDel)
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    
    func requestBlogPosts(appDel: AppDelegate){
        let context = appDel.managedObjectContext
        let url = NSURL(string: "https://www.googleapis.com/blogger/v3/blogs/10861780/posts?key=AIzaSyBB39BG_yCDl0Mv47zfeJnbJHoByFYOKMU")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            if let urlContent = data {
                    
                    do {
                        
                        let request = NSFetchRequest(entityName: "BlogItems")
                        request.returnsObjectsAsFaults = false
                        let results = try context.executeFetchRequest(request)
                        for result in results {
                            context.deleteObject(result as! NSManagedObject)
                        }
                        try context.save()
                    
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    //                    print(jsonResult["items"])
                    
                    var objects = [[String:String]()]
                    
                    if let items = jsonResult["items"] as? [AnyObject] {
                        
                            var newBlogItem: NSManagedObject! = nil
                        
                            for var i = 0; i < items.count; i++ {
                                if let item = items[i] as? [String: AnyObject],
                                    let authorDictionary = item["author"] as? [String: AnyObject],
                                    let content = item["content"] as? String,
                                    let title = item["title"] as? String,
                                    let author = authorDictionary["displayName"] as? String,
                                    let date = item["published"] as? String {
                                        objects.append([String:String]())
                                        objects[i]["author"] = author
                                        objects[i]["title"] = title
                                        objects[i]["content"] = content
                                        objects[i]["publishedDate"] = date
                                        
                                            newBlogItem = NSEntityDescription.insertNewObjectForEntityForName("BlogItems", inManagedObjectContext: context) as NSManagedObject
                                            
                                            newBlogItem.setValue(objects[i]["author"], forKey: "author")
                                            newBlogItem.setValue(objects[i]["title"], forKey: "title")
                                            newBlogItem.setValue(objects[i]["content"], forKey: "content")
                                            newBlogItem.setValue(objects[i]["publishedDate"], forKey: "publishedDate")
                                            
                                            do {
                                                try context.save()
                                            } catch {
                                                print("ERROR - SAVING CORE DATA")
                                            }
                                        
                                        
                                }
                            }
                        
                    }
                    } catch {
                        print("ERROR - SAVING CORE DATA")
                    }
                    
                    
                    
                    
                    // unwrapping
                    //                    if let city = jsonResult["city"] as? String {
                    //                        print(city)
                    //                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //
                    //                        })
                    //                    }

            }
        }
        task.resume()


    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func refreshScreen(sender: AnyObject) {
        requestBlogPosts(appDel)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = self.fetchedResultsController.objectAtIndexPath(indexPath)

                activeItem = (object.valueForKey("content")?.description)!
//                print(activeItem)
                
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let mycontext = self.fetchedResultsController.managedObjectContext
            mycontext.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath))
                
            do {
                try mycontext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                
                print("Unresolved error \(error)")
                abort()
            }
        }
    }

    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath)
        cell.textLabel!.text = object.valueForKey("title")!.description
        cell.detailTextLabel?.text = object.valueForKey("author")!.description
        let logo = UIImage(named: "google.png")
        cell.imageView?.image = logo
    }
    
    
    // MARK: - Fetched results controller

    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entityForName("BlogItems", inManagedObjectContext: self.managedObjectContext!)
        fetchRequest.entity = entity
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "publishedDate", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
//             print("Unresolved error \(error)")
            
//            print("HEEEEERE")
             abort()
        }
        
        return _fetchedResultsController!
    }    
    var _fetchedResultsController: NSFetchedResultsController? = nil

    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }

    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
            case .Insert:
                self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            case .Delete:
                self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            default:
                return
        }
    }

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: NSManagedObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
            case .Insert:
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            case .Delete:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            case .Update:
                self.configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, atIndexPath: indexPath!)
            case .Move:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        }
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }

    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         self.tableView.reloadData()
     }
     */

}

