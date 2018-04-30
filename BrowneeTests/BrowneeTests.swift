//
//  BrowneeTests.swift
//  BrowneeTests
//
//  Created by Benjamin Bucca on 4/30/18.
//  Copyright © 2018 Animal Assistance. All rights reserved.
//

import XCTest
@testable import Brownees_World

class BrowneeTests: XCTestCase {
    
    func testViewController() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: ViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let vcHome = vc
        _ = vcHome.view // To call viewDidLoad
        
        XCTAssertNotNil(vc)
    }
    
    func testOrganization() {
        //        let testDictionary = ["name": "Animal Assistance ", "address": "645 Old Stage Rd", "city": "East Brunswick", "state": "NJ", "country": "United States", "zipcode": "08816", "phone": "(732) 251-3210", "website": "http://www.animalassistance.org", "id": "8177"]
        //
        //        if let json = try? JSONSerialization.data(withJSONObject: testDictionary, options: []) {
        //            // here `json` is your JSON data
        //
        //            if let jsonOrg = try? JSONSerialization.jsonObject(with: json, options: []) {
        //
        //                let testOrg = Organization(json: jsonOrg as! JSON)
        //                XCTAssertNotNil(testOrg)
        //            }
        //
        //        }
    }
    
}
