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
    
    //MARK: Properties
    
    @IBOutlet weak var scoreField: UITextField!
    
    @IBOutlet weak var questionField: UITextView!
    
    @IBOutlet weak var dogImage: UIImageView!
    
    @IBOutlet weak var dogFoodImage: UIImageView!
    
    @IBOutlet weak var dogHouseImage: UIImageView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    // Received question array from specific segue
    var questionArray : [Question] = []
    // Index for each question in questionArray
    var questionIndex : Int = 0
    // Index for dogImage animation
    var dogIndex : CGFloat = 0.0
    
    // Yes button
    @IBAction func trueButton(_ sender: UIButton) {
        self.checkAnswer(true)
    }
    // No button
    @IBAction func falseButton(_ sender: UIButton) {
        self.checkAnswer(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set label text of question category
        categoryLabel.text = questionArray[questionIndex].category
        // Set first question text
        questionField.text = questionArray[questionIndex].question
        // Create custom background gradient
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
        showNextQuestion()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private Functions
    
    // function that displays next question text from array of questions and updates score
    private func showNextQuestion() {
        questionField.text = questionArray[questionIndex].question
        scoreField.text = "Question number: " + String(questionIndex + 1) + " / " + String(questionArray.count)
    }
    
    // function that accepts either true or false (usersAnswer)
    private func checkAnswer(_ usersAnswer: Bool) {
        // check usersAnswer true
        if (questionArray[questionIndex].ans == usersAnswer) {
            // show dog image, dogbowl image and doghouse image
            dogImage.isHidden = false
            dogFoodImage.isHidden = false
            dogHouseImage.isHidden = false
            
            // animate dog image for each correct answer
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
                self.dogIndex += (self.view.frame.width * (10/120))
                self.dogImage.transform = CGAffineTransform(translationX: CGFloat(self.dogIndex), y: 0)
            }, completion: { (true) in
                print("animation complete ", self.dogIndex)
            })
            
            // increment (question) array index
            questionIndex += 1
            // if question # is greater than or equal to num of questions then seque back
            if (questionIndex >= questionArray.count) {
                // call function to present Finished modal
                self.finishedWithQuestions()
                return
            }
            // update question text field and score
            showNextQuestion()
        }
        // check usersAnswer false
        else {
            // show modal for consideration to answer
            DispatchQueue.main.async { [unowned self] in
                let alertView = JSSAlertView().warning(
                    self,
                    title: "Consider",
                    text: self.questionArray[self.questionIndex].explanation,
                    buttonText: "Ok"
                    )
                alertView.addAction(self.showNextQuestion)
                alertView.setTitleFont("Helvetica")
                alertView.setTextFont("Helvetica")
                alertView.setButtonFont("Helvetica")
            }
            
        }
    }
    
    private func finishedWithQuestions() {
        let customIcon:UIImage! = UIImage(named: "dog_footprint_filled")        
        DispatchQueue.main.async { [unowned self] in
            let alertView = JSSAlertView().show(
                self,
                title: "Finished",
                text: "Good job!",
                buttonText: "Ok",
                color: UIColorFromHex(0xFFF7F0, alpha: 0.85),
                iconImage: customIcon)
            alertView.addAction(self.finishedSegue)
            alertView.setTitleFont("Helvetica")
            alertView.setTextFont("Helvetica")
            alertView.setButtonFont("Helvetica")
        }
    }
    
    //MARK: Navigation
    
    private func finishedSegue() {
        self.performSegue(withIdentifier: "cancelSegue", sender: self)
        return
    }
}
