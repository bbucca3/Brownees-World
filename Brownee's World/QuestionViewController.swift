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
    
    @IBOutlet weak var dogHouseImage: UIImageView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    // received from segue
    var questionArray : [Question] = []
    // index for questionArray
    var currentIndex : Int = 0
    // index for dogImage transform
    var dogIndex : Float = 0.0
    // yes button
    @IBAction func trueButton(_ sender: UIButton) {
        self.checkAnswer(true)
    }
    // no button
    @IBAction func falseButton(_ sender: UIButton) {
        self.checkAnswer(false)
    }
    
    // function that accepts either true or false (usersAnswer)
    func checkAnswer(_ usersAnswer: Bool) {
        // check usersAnswer true or false
        if(questionArray[currentIndex].ans == usersAnswer) {
            // show dog and dogbowl image
            dogImage.isHidden = false
            dogFoodImage.isHidden = false
            dogHouseImage.isHidden = false 
            // distance to increase dog each question
            dogIndex += 20.0
            // animate dog for each correct answer
            UIView.animate(withDuration: 1.0, animations: {
                self.dogImage.transform = CGAffineTransform(translationX: CGFloat(self.dogIndex), y: 0)
            }) 
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
            // show modal for consideration answer
            DispatchQueue.main.async { [unowned self] in
                let alertView = JSSAlertView().warning(
                    self,
                    title: "Consider",
                    text: self.questionArray[self.currentIndex].explanation,
                    buttonText: "Ok"
                    )
                alertView.addAction(self.showNextQuestion)
                alertView.setTitleFont("Helvetica")
                alertView.setTextFont("Helvetica")
                alertView.setButtonFont("Helvetica")
            }
            
        }
    }
    
    // function that displays next question text from array of questions and updates score
    func showNextQuestion() {
        questionField.text = questionArray[currentIndex].question
        scoreField.text = "Question number: " + String(currentIndex+1) + " / " + String(questionArray.count)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // index for going through questionArray
        currentIndex = 0
        // label text of question category
        categoryLabel.text = questionArray[currentIndex].category
        // question text
        questionField.text = questionArray[currentIndex].question
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
        showNextQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func finishedWithQuestions() {
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
    
    func finishedSegue() {
        self.performSegue(withIdentifier: "cancelSegue", sender: self)
        return
    }
}
