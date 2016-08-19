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
    //@IBOutlet weak var skipButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  skipButton.addTarget(self, action: Selector("clickMe"), forControlEvents: .TouchUpInside)
       // skipButton.hidden = false
        // Do any additional setup after loading the view.
        let onboarding = PaperOnboarding(itemsCount: 3)
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
 
        self.view.addSubview(skipButton)
        
        // add constraints
        for attribute: NSLayoutAttribute in [.Left, .Right, .Top, .Bottom] {
            let constraint = NSLayoutConstraint(item: onboarding, attribute: attribute,relatedBy: .Equal, toItem: view, attribute: attribute, multiplier: 1, constant: 0)
            view.addConstraint(constraint)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func onboardingWillTransitonToIndex(index: Int) {
        // skipButton.hidden = index == 2 ? false : true
    }
    
    func onboardingDidTransitonToIndex(index: Int) {
        
    }
    
    func onboardingItemAtIndex(index: Int) -> OnboardingItemInfo {
        
        let titleFont = UIFont(name: "Helvetica Neue", size: 38.0) ?? UIFont.boldSystemFontOfSize(36.0)
        let descriptionFont = UIFont(name: "Helvetica Neue", size: 16.0) ?? UIFont.systemFontOfSize(14.0)
        
        return[
            ("footOnboard", "Education", "Answer questions about the life of a rescue dog, and dogs in general. Swipe right to learn more.", "dog_footprint_tab", UIColorFromHex(0xECDACC), UIColorFromHex(0x442C1D), UIColorFromHex(0x442C1D), titleFont, descriptionFont),
            ("houseOnboard", "Get Involved", "Search for animal shelters and rescue organizations within a 20 mile radius from any US zipcode.", "dog_house_tab", UIColorFromHex(0xF8E6D6), UIColorFromHex(0x442C1D), UIColorFromHex(0x442C1D), titleFont, descriptionFont),
            ("browneeOnboard", "Brownee's World", "Search and show contact info for local rescue organizations or shelters in your area to donate supplies or possibly volunteer. Test your knowledge about rescue dogs with questions designed for all ages.", "dogTab", UIColorFromHex(0xFFF7F2), UIColorFromHex(0x442C1D), UIColorFromHex(0x442C1D), titleFont, descriptionFont)
            ][index]
    }
    
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

