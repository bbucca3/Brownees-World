//
//  OnboardViewController.swift
//  Brownees World
//
//  Created by Benjamin Bucca on 8/11/16.
//  Copyright © 2016 Animal Assistance. All rights reserved.
//

import UIKit
import paper_onboarding
import Foundation
import JSSAlertView

class OnboardViewController: UIViewController, PaperOnboardingDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  Onboarding init
        let onboarding = PaperOnboarding(itemsCount: 4)
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(onboarding)
        // Add constraints for onboarding
        for attribute: NSLayoutAttribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding, attribute: attribute, relatedBy: .equal, toItem: view, attribute: attribute, multiplier: 1, constant: 0)
            view.addConstraint(constraint)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Create onboarding screens
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        // Font for each title text
        let titleFont = UIFont(name: "Helvetica Neue", size: 38.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
        // Font for each description text
        let descriptionFont = UIFont(name: "Helvetica Neue", size: 16.0) ?? UIFont.systemFont(ofSize: 14.0)
        // Each array item: main image, title text, description text, tab image, background color, title text color, description text color, title font, description font
        return[
            (UIImage(named:"browneeOnboard")!, "Brownee's World", "Welcome to Brownee's World! Swipe left to see more information. Swipe right to skip.", UIImage(named:"dogTab")!, UIColorFromHex(0xFFF7F2), UIColorFromHex(0x442C1D), UIColorFromHex(0x442C1D), titleFont, descriptionFont),
            
            (UIImage(named:"footOnboard")!, "Education", "Play a game answering questions about a dog's life before and after adoption from a shelter. Swipe left to see more or swipe right to go back.", UIImage(named:"dog_footprint_tab")!, UIColorFromHex(0xF8E6D6), UIColorFromHex(0x442C1D), UIColorFromHex(0x442C1D), titleFont, descriptionFont),
            
            (UIImage(named:"houseOnboard")!, "Search", "Look for animal shelters and rescue organizations via any 5 digit ZIP code. Swipe left to see more or swipe right to go back.", UIImage(named:"dog_house_tab")!, UIColorFromHex(0xFFF7F2), UIColorFromHex(0x442C1D), UIColorFromHex(0x442C1D), titleFont, descriptionFont),
            (UIImage(named:"tagOnboard")!, "Support", "View a list of common items that animal shelters will (most likely) accept as donations. Swipe left to exit. Swipe right to go back.", UIImage(named:"newSupportTab")!, UIColorFromHex(0xF8E6D5), UIColorFromHex(0x442C1D), UIColorFromHex(0x442C1D), titleFont, descriptionFont)
            ][index]
    }
    
    // Number of onboarding screens
    func onboardingItemsCount() -> Int {
        return 4
    }

}

