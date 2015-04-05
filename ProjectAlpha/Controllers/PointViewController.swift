//
//  PointViewController.swift
//  ProjectAlpha
//
//  Created by Nicolas Langley on 4/5/15.
//  Copyright (c) 2015 Nicolas Langley. All rights reserved.
//

import Foundation

class PointViewController: UIViewController {

    @IBOutlet weak var pointTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyImageView: UIImageView!
    
    var pointOverviewString: String?
    var pointDetailString: String?
    var companyImageName: String?
    var nameString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set labels
        self.pointTextView.text = pointDetailString!
        self.pointTextView.textColor = UIColor.whiteColor()
        self.pointTextView.textAlignment = NSTextAlignment.Center
        self.pointTextView.editable = false
        self.pointTextView.scrollRangeToVisible(NSMakeRange(0, 0))
        
        // Header label and image for company
        self.companyImageView.image = UIImage(named: companyImageName!)
        self.nameLabel.text = nameString!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
