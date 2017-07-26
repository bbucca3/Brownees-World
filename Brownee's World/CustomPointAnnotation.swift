//
//  CustomPointAnnotation.swift
//  Brownees World
//
//  Created by Benjamin Bucca on 8/4/16.
//  Copyright © 2016 Animal Assistance. All rights reserved.
//

import UIKit
import MapKit

class CustomPointAnnotation: MKPointAnnotation {
    
    var imageName: String?
    var website: String?
    var phoneNum: String?
    
    override init() {
        self.imageName = imageName ?? ""
        self.website = website ?? ""
        self.phoneNum = phoneNum ?? ""
    }
    
}
