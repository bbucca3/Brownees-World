//
//  InfoViewController.swift
//  Brownees World
//
//  Created by Benjamin Bucca on 8/11/16.
//  Copyright © 2016 Animal Assistance. All rights reserved.
//

import UIKit
import JSSAlertView

class InfoViewController: UIViewController {

    // donate to animal assistance
    @IBAction func donateButton(sender: AnyObject) {
        // implicit unwrap url open in safari
        if let requestUrl = NSURL(string: "http://animalassistance.org/donate.html") {
            UIApplication.sharedApplication().openURL(requestUrl)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // custom background gradient
        let topColor = UIColorFromHex(0xFFF7F0, alpha: 1.0)
        let bottomColor = UIColorFromHex(0xECDACC, alpha: 1.0)
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, atIndex: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
