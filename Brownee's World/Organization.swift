//
//  Organization.swift
//  Brownees World
//
//  Created by Benjamin Bucca on 8/1/16.
//  Copyright © 2016 Animal Assistance. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Organization {
    let name: String
    let address: String
    let city: String
    let state: String
    let country: String
    let zipcode: String
    let phone: String
    let website: String
    
    init(json: JSON) {
        self.name = json["orgName"].stringValue
        self.address = json["orgAddress"].stringValue
        self.city = json["orgCity"].stringValue
        self.state = json["orgState"].stringValue
        self.country = json["orgCountry"].stringValue
        self.zipcode = json["orgPostalcode"].stringValue
        self.phone = json["orgPhone"].stringValue
        self.website = json["orgWebsiteUrl"].stringValue
    }
}
