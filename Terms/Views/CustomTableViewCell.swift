//
//  CustomTableViewCell.swift
//  ProjectAlpha
//
//  Created by Michael Levin on 12/30/14.
//  Copyright (c) 2014 Nicolas Langley. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myMiddleLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myImageViewGrade: UIImageView!
    
    //    self.myImageView.image.contentMode = UIViewContentModeScaleAspectFit
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(middleLabelText: String, imageName: String, imageGradeName: String){
        
        self.myMiddleLabel.text = middleLabelText
        self.myImageView.image = UIImage(named: imageName)
        self.myImageViewGrade.image = UIImage(named: imageGradeName)
        
    }
    
    
}
