//
//  CustomTableViewCell2.swift
//  ProjectAlpha
//
//  Created by Michael Levin on 4/5/15.
//  Copyright (c) 2015 Nicolas Langley. All rights reserved.
//

import Foundation

class CustomTableViewCell2: UITableViewCell {
    
    @IBOutlet weak var myTextLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    
    //    self.myImageView.image.contentMode = UIViewContentModeScaleAspectFit
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell2(myText: String, myImage: String){
        
        self.myTextLabel.text = myText
        self.myImageView.image = UIImage(named: myImage)
        
    }
    
    
}