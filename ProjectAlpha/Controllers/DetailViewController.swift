//
//  DetailViewController.swift
//  ProjectAlpha
//
//  Created by Michael Levin on 12/30/14.
//  Copyright (c) 2014 Nicolas Langley. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var myDetailedImageView: UIImageView!
    @IBOutlet weak var tosTextView: UITextView!
    
    // Custom Table View
    @IBOutlet var tableView: UITableView!
    
    var nameString: String?
    var tosLinkString: String?
    var myDetailedImageName: String?
    var pointsDict: Dictionary<String,[String]> = Dictionary<String,[String]>()
    var pointsTitleArr: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set labels
        self.nameLabel.text = nameString!
        
        if (tosLinkString! == "N/A") {
            self.tosTextView.text = "Terms Not Available"
        } else {
            self.tosTextView.text = tosLinkString!
        }
        self.tosTextView.editable = false
        self.tosTextView.dataDetectorTypes = UIDataDetectorTypes.Link
        self.tosTextView.tintColor = UIColor.whiteColor()
        
        self.myDetailedImageView.image = UIImage(named: myDetailedImageName!)
        
        for (title, type) in pointsDict {
            self.pointsTitleArr.append(title)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // TableView functions
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pointsDict.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell: CustomTableViewCell2 = tableView.dequeueReusableCellWithIdentifier("Cell1") as CustomTableViewCell2

        cell.myTextLabel?.text = self.pointsTitleArr[indexPath.row]
        cell.myTextLabel.numberOfLines = 2
        cell.myTextLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        var downUp = "Z.png"
        let type = self.pointsDict[self.pointsTitleArr[indexPath.row]]![0]
        if (type == "good") {
            cell.textLabel?.textColor = UIColor(red: 0.13, green: 0.55, blue: 0.13, alpha: 0.8)
            downUp = "check1.png"
        } else if (type == "bad") {
            cell.textLabel?.textColor = UIColor(red: 0.70, green: 0.13, blue: 0.13, alpha: 0.8)
            downUp = "x1.png"
        }

        cell.setCell2(self.pointsTitleArr[indexPath.row],myImage: downUp)
            
        return cell
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // TODO: What happens on selection?
        
        var pointViewController : PointViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PointViewController") as PointViewController
        
        pointViewController.pointDetailString = self.pointsDict[self.pointsTitleArr[indexPath.row]]![1]
        pointViewController.pointOverviewString = self.pointsTitleArr[indexPath.row]
        pointViewController.nameString = self.nameString
        pointViewController.companyImageName = self.myDetailedImageName
        
        self.presentViewController(pointViewController, animated: true, completion: nil)
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
