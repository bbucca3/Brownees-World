//
//  InfoViewController.swift
//  Brownees World
//
//  Created by Benjamin Bucca on 8/11/16.
//  Copyright © 2016 Animal Assistance. All rights reserved.

import UIKit
import JSSAlertView

class InfoViewController: UIViewController {
    
    @IBOutlet weak var supportText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // sets scrolling text view to top
        supportText.isScrollEnabled = false
        // custom background gradient
        let topColor = UIColorFromHex(0xFFF7F0, alpha: 1.0)
        let bottomColor = UIColorFromHex(0xECDACC, alpha: 1.0)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // prevents auto initial scroll to bottom
        supportText.isScrollEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func donateButton(_ sender: AnyObject) {
        
        guard let url = URL(string: "http://www.animalassistance.org/donations/") else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }
    
    
    @IBAction func registerShelterButton(_ sender: UIButton) {
        let customIcon:UIImage! = UIImage(named: "dog_house_tab_filled")
        DispatchQueue.main.async { [unowned self] in
            let alertView = JSSAlertView().show(
                self,
                title: "Open RescueGroups Sign Up Link",
                text: "Follow the instructions via the link on the next page to register a rescue organization or shelter for the RescueGroups API search.",
                buttonText: "Open",
                cancelButtonText: "Close",
                color: UIColorFromHex(0xFFF7F0, alpha: 0.95),
                iconImage: customIcon)
            alertView.addAction(self.visitRescueGroups)
            alertView.setTitleFont("Helvetica")
            alertView.setTextFont("Helvetica")
            alertView.setButtonFont("Helvetica")
        }
    }
    
    // function to open rescue groups sign up website
    func visitRescueGroups() {
        guard let url = URL(string: "https://rescuegroups.org/sign-up/") else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

    // MARK: - Navigation
 
    @IBAction func unwindToInfo(segue:UIStoryboardSegue) {
    // unwind from donation items list
    }

}
