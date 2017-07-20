//
//  ViewController.swift
//  Brownee's World
//
//  Created by Benjamin Bucca on 7/20/16.
//  Copyright © 2016 Animal Assistance. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITabBarDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let topColor = hexStringToUIColor("FFF7F0")
        let bottomColor = hexStringToUIColor("ECDACC")
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        //state the font that we want
        let font = UIFont(name: "Helvetica", size: 12)
        //input the font and it's color
        let objs = NSArray(objects: font!, hexStringToUIColor("442C1D"))
        //selected objs
        let selectedObjs = NSArray(objects: font!, hexStringToUIColor("442C1D"))
        //setting it
        let keys = NSArray(objects: NSFontAttributeName, NSForegroundColorAttributeName)
        UITabBarItem.appearance().setTitleTextAttributes(NSDictionary(objects: objs as [AnyObject], forKeys: keys as! [NSCopying]) as? [String : AnyObject], for: UIControlState.normal)
        UITabBarItem.appearance().setTitleTextAttributes(NSDictionary(objects: selectedObjs as [AnyObject], forKeys: keys as! [NSCopying]) as? [String : AnyObject], for: UIControlState.selected)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func aboutButton(_ sender: UIButton) {
    }
    
    @IBAction func educationButton(_ sender: UIButton) {
        tabBarController?.selectedIndex = 1
    }
    
    @IBAction func involvedButton(_ sender: UIButton) {
         tabBarController?.selectedIndex = 2
    }
    
    
    func hexStringToUIColor (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: (NSCharacterSet.whitespacesAndNewlines as NSCharacterSet) as CharacterSet).uppercased()
//        if (cString.hasPrefix("#")) {
//            cString = cString.substring(from: cString.startIndex.advancedBy(1))
//        }
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
            )
    }
    
    @IBAction func homeSegue(_ segue: UIStoryboardSegue) {
        
    }
    
}

