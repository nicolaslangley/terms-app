//
//  ListOfApplications.swift
//  ProjectAlpha
//
//  Created by Michael Levin on 12/23/14.
//  Copyright (c) 2014 Nicolas Langley. All rights reserved.
//

import UIKit

class ListOfApplications: NSObject {

    var arrayOfSingleApplications = [SingleApplication]()
    
    func addApplication(singleapp: SingleApplication){
        arrayOfSingleApplications.append(singleapp)
    }
    
    
}