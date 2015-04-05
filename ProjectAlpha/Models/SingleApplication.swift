//
//  SingleApplication.swift
//  ProjectAlpha
//
//  Created by Michael Levin on 12/24/14.
//  Copyright (c) 2014 Nicolas Langley. All rights reserved.
//

import UIKit

class SingleApplication: NSObject {
    
    var name = "blank"
    var imageGrade = "blank"
    var image = "blank"
    var terms = "blank"
    var pointsDict: Dictionary<String,[String]> = Dictionary<String,[String]>()
    
    override init(){}
    
    init(name:String,imageGrade:String,image:String,terms: String,points: Dictionary<String,[String]>){
        self.name = name
        self.imageGrade = imageGrade
        self.image = image
        self.pointsDict = points
        self.terms = terms
    }
    
}