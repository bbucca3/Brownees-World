//
//  QuestionViewController.swift
//  Brownees World
//
//  Created by Benjamin Bucca on 7/26/16.
//  Copyright © 2016 Animal Assistance. All rights reserved.
//

import UIKit
import JSSAlertView
import CoreGraphics

// class for each question game
class QuestionViewController: UIViewController {
    
    @IBOutlet weak var scoreField: UITextField!
    
    @IBOutlet weak var questionField: UITextView!
    
    @IBOutlet weak var dogImage: UIImageView!
    
    @IBOutlet weak var dogFoodImage: UIImageView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    // received from segue
    var questionArray : [Question] = []
    // index for questionArray
    var currentIndex : Int = 0
    // index for dogImage transform
    var dogIndex : Float = 0.0
    // yes button
    @IBAction func trueButton(sender: UIButton) {
        self.checkAnswer(true)
    }
    // no button
    @IBAction func falseButton(sender: UIButton) {
        self.checkAnswer(false)
    }
    
    // function that accepts either true or false (usersAnswer)
    func checkAnswer(usersAnswer: Bool) {
        // check usersAnswer true or false
        if(questionArray[currentIndex].ans == usersAnswer) {
            // show dog and dogbowl image
            dogImage.hidden = false
            dogFoodImage.hidden = false
            // distance to increase dog each question
            dogIndex += 20.0
            // animate dog for each correct answer
            UIView.animateWithDuration(1.0) {
                self.dogImage.transform = CGAffineTransformMakeTranslation(CGFloat(self.dogIndex), 0)
            }
            // increment (question) array index
            currentIndex += 1
            // if question # is greater than or equal to num of questions then seque back
            if(currentIndex >= questionArray.count) {
                // call function to present finished modal
                self.finishedWithQuestions()
                return
            }
            // update question text field and score
            showNextQuestion()
        }
            
        else {
            // show modal for considering
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                let alertView = JSSAlertView().show(
                    self,
                    title: "Consider",
                    text: self.questionArray[self.currentIndex].explanation,
                    buttonText: "Ok",
                    color: UIColorFromHex(0x942522, alpha: 1))
                alertView.addAction(self.showNextQuestion)
                alertView.setTitleFont("Helvetica")
                alertView.setTextFont("Helvetica")
                alertView.setButtonFont("Helvetica")
            }
            
        }
    }
    
    // function that shows next question from array of questions
    func showNextQuestion() {
        questionField.text = questionArray[currentIndex].question
        scoreField.text = "Question number: " + String(currentIndex+1) + " / " + String(questionArray.count)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // index for going through questionArray
        currentIndex = 0
        categoryLabel.text = questionArray[currentIndex].category
        questionField.text = questionArray[currentIndex].question
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
    
    override func viewDidAppear(animated: Bool) {
        showNextQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func finishedWithQuestions() {
        let customIcon:UIImage! = UIImage(named: "dog_footprint_filled")        
        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
            let alertView = JSSAlertView().show(
                self,
                title: "Finished",
                text: "Good job!",
                buttonText: "Ok",
                color: UIColorFromHex(0xFFF7F0, alpha: 1),
                iconImage: customIcon)
            alertView.addAction(self.finishedSegue)
            alertView.setTitleFont("Helvetica")
            alertView.setTextFont("Helvetica")
            alertView.setButtonFont("Helvetica")
        }
    }
    
    func finishedSegue() {
        self.performSegueWithIdentifier("cancelSegue", sender: self)
        return
    }
    

}
