//
//  AboutViewController.swift
//  Brownees World
//
//  Created by Benjamin Bucca on 8/11/16.
//  Copyright © 2016 Animal Assistance. All rights reserved.
//

import UIKit
import paper_onboarding
import Foundation
import JSSAlertView

class AboutViewController: UIViewController, PaperOnboardingDataSource {

    @IBOutlet weak var skipButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  paper onboarding
        let onboarding = PaperOnboarding(itemsCount: 3)
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
 
        self.view.addSubview(skipButton)
        
        // add constraints
        for attribute: NSLayoutAttribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding, attribute: attribute,relatedBy: .equal, toItem: view, attribute: attribute, multiplier: 1, constant: 0)
            view.addConstraint(constraint)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        // skipButton.hidden = index == 2 ? false : true
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        
    }
    // func for onboarding
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        // font for each title text
        let titleFont = UIFont(name: "Helvetica Neue", size: 38.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
        // font for each description text
        let descriptionFont = UIFont(name: "Helvetica Neue", size: 16.0) ?? UIFont.systemFont(ofSize: 14.0)
        // array: main image, title text, description text, tab image, background color,
        // title text color, description text color, title font, description font
        return[
            ("browneeOnboard", "Brownee's World", "Please swipe right", "dogTab", UIColorFromHex(0xFFF7F2), UIColorFromHex(0x442C1D), UIColorFromHex(0x442C1D), titleFont, descriptionFont),
            ("footOnboard", "Education", "Engage in questions about the life of a rescue dog, and dogs in general. Swipe right to see more information.", "dog_footprint_tab", UIColorFromHex(0xFDF1E6), UIColorFromHex(0x442C1D), UIColorFromHex(0x442C1D), titleFont, descriptionFont),
            ("houseOnboard", "Get Involved", "Search for animal shelters/rescue organizations within a 5, 10, 15, or 20 mile radius from any US zipcode. Please allow a moment for search to load.", "dog_house_tab", UIColorFromHex(0xF8E6D6), UIColorFromHex(0x442C1D), UIColorFromHex(0x442C1D), titleFont, descriptionFont)
            ][index]
    }
    // func for number of onboarding pages
    func onboardingItemsCount() -> Int {
        return 3
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

