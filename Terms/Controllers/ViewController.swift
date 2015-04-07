//
//  ViewController.swift
//  ProjectAlpha
//
//  Created by Nicolas Langley on 12/21/14.
//  Copyright (c) 2014 Nicolas Langley. All rights reserved.
//

import UIKit
import CoreData

import Alamofire
import SwiftyJSON
import iHasApp

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tblApps: UITableView!
    
    var listApp: [SingleApplication] = [SingleApplication]()
    
    // Global variables for iHasApp detection
    var detectedApps = []
    var matchedApps: [String] = []
    let detectionObject: iHasApp = iHasApp()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.matchedApps = []
        self.detectApps()
        // Asynchronous! -> detectApps calls setupApps calls tableReload
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return listApp.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell: CustomTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as CustomTableViewCell
        
        cell.backgroundColor = UIColor.blackColor()
        cell.myMiddleLabel.textColor = UIColor.whiteColor()
        //        cell.myMiddleLabel.sizeToFit()
        
        
        let app = listApp[indexPath.row]
        
        cell.setCell(app.name, imageName: app.image, imageGradeName: app.imageGrade)
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let app = listApp[indexPath.row]
        
        var detailedViewController : DetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as DetailViewController
        
        detailedViewController.nameString = app.name
        detailedViewController.myDetailedImageName = app.image
        detailedViewController.pointsDict = app.pointsDict
        detailedViewController.tosLinkString = app.terms
        
        self.presentViewController(detailedViewController, animated: true, completion: nil)
        self.tblApps.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func setUpApps()
    {
        for detectedapp in detectedApps {
            let appTitle: AnyObject? = detectedapp["trackName"]
            if let theTitle = appTitle as? String {
                // Retrieve CoreData object for this app
                var appManagedObject = self.queryCoreData(theTitle)
                
                if (appManagedObject != nil) {
                    // Retrieve data from CoreData object
                    let appName = appManagedObject?.valueForKey("name") as String
                    
                    let grade = appManagedObject?.valueForKey("classRating") as String
                    let gradePath = generatePathFromFileTitle(grade)
                    
                    let termsLink = appManagedObject?.valueForKey("termsLink") as String
                    let pointsDict = appManagedObject?.valueForKey("pointsDict") as Dictionary<String,[String]>
                    
                    if appName.rangeOfString(".com") != nil {
                        continue
                    }
                    let iconPath = generatePathFromFileTitle(appName)
                    
                    var app = SingleApplication(name: appName,
                                                imageGrade: gradePath,
                                                image: iconPath,
                                                terms: termsLink,
                                                points: pointsDict)
                    listApp.append(app)
                    
                    
                } else {
                    // There is no CoreData entry for this app - i.e. it is not on TOSDR
                    // TODO: there has to be a better check for this
                }
            }
        }
        tblApps.reloadData();
    }
    
    func generatePathFromFileTitle(g: String) -> String
    {
        
        let imagePath = NSBundle.mainBundle().pathForResource(g, ofType: "png")

        if imagePath==nil{
            let imagePathBackup = NSBundle.mainBundle().pathForResource("Z", ofType: "png")
            return imagePathBackup!
        }
        
        return imagePath!

    }
    
    func detectApps()
    {
        self.detectionObject.detectAppDictionariesWithIncremental({
            (appDictionaries: [AnyObject]!) -> Void
            in
            NSLog("Incremental appDictionaries.count: %i", appDictionaries.count)
            self.detectedApps.arrayByAddingObjectsFromArray(appDictionaries)
            },
            withSuccess:{
                (appDictionaries: [AnyObject]!) -> Void
                in
                NSLog("Successful appDictionaries.count: %i", appDictionaries.count)
                self.detectedApps = appDictionaries
                NSLog("")
                self.setUpApps();
            },
            withFailure:{
                (error: NSError!) -> Void
                in
                NSLog("Failure: %@", error.localizedDescription)
                self.detectedApps = []
        })
        
    }
    
    func printCoreData()
    {
        var apps = []
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!

        let fetchRequest = NSFetchRequest(entityName:"Application")
        
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            apps = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    /**
    Given an input string check if it matches the name of any applications in CoreData

    :params: input Given string
    :return: NSManagedObject
    */
    func queryCoreData(input: String) -> NSManagedObject?
    {
        // Check if any of the CoreData entries are substrings of input
        var apps = []
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName:"Application")
        
        var error: NSError?
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [NSManagedObject]?
        // println("Input is: \(input)")
        if let results = fetchedResults {
            apps = results
            
            // Iterate through apps in CoreData and compare with input
            for app in apps {
                if let appName = app.valueForKey("name") as? String {
                    // println("Checking against: \(appName)")
                    if (input.lowercaseString.rangeOfString(appName) != nil) {
                        // There is a match
                        // println("Match found")
                        
                        // Check if we have already found a match for this app
                        if (contains(self.matchedApps, appName)) {
                            continue
                        } else {
                            self.matchedApps.append(appName)
                        }
                        return app as? NSManagedObject
                    }
                }
            }
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        return nil
    }
    
  
    
}

