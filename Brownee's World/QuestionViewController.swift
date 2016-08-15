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

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var scoreField: UITextField!
    
    @IBOutlet weak var questionField: UITextView!
    
    @IBOutlet weak var dogImage: UIImageView!
    
    var questionArray : [Question] = []
    
    var currentIndex : Int = 0
    var dogIndex : Float = 0.0

    @IBAction func trueButton(sender: UIButton) {
        self.checkAnswer(true)
    }
    
    @IBAction func falseButton(sender: UIButton) {
        self.checkAnswer(false)
    }
    
    func checkAnswer(usersAnswer: Bool) {
        // usersAnswer either true or false
        if(questionArray[currentIndex].ans == usersAnswer) {
            dogImage.hidden = false
            dogIndex += 10.0
            
            UIView.animateWithDuration(1.0) {
                self.dogImage.transform = CGAffineTransformMakeTranslation(CGFloat(self.dogIndex), 0)
            }
            // increment array index
            currentIndex += 1
            
            if(currentIndex >= questionArray.count) {
                self.performSegueWithIdentifier("cancelSegue", sender: self)
                return
            }
            
            showNextQuestion()
        }
            
        else {
            
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
            
            //questionField.text = questionArray[currentIndex].question + "\n\n" + questionArray[currentIndex].explanation
        }
    }
    
    func showNextQuestion() {
        questionField.text = questionArray[currentIndex].question
        scoreField.text = "Question number: " + String(currentIndex+1) + " / " + String(questionArray.count)
    }
    
//    func finishedWithQuestions() {
//        self.performSegueWithIdentifier("cancelSegue", sender: self)
//        return
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentIndex = 0
        questionField.text = questionArray[currentIndex].question
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        showNextQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
