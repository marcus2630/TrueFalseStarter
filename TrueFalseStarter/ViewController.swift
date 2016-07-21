//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion = 0
    
    var gameSound: SystemSoundID = 0
    
    let trivia = QuestionCollection
    
    @IBOutlet weak var questionField: UILabel!
    
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
    
    @IBOutlet weak var playAgainButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        // Start game
        playGameStartSound()
        displayQuestion()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func randomNumberNoRepeat() {
        
        var randomNumber = GKRandomSource.sharedRandom().nextIntWithUpperBound(range)
        while previousNumber == randomNumber {
            randomNumber = GKRandomSource.sharedRandom().nextIntWithUpperBound(range)
        }
        previousNumber = randomNumber
        return randomNumber
    }
    
    func displayQuestion() {
        indexOfSelectedQuestion = randomNumberNoRepeat(trivia.count)
        let questionDictionary = trivia[indexOfSelectedQuestion]
        questionField.text = questionDictionary.question
        playAgainButton.hidden = true
        
        answer1.setTitle(questionDictionary.answer1, forState: .Normal)
        answer2.setTitle(questionDictionary.answer2, forState: .Normal)
        answer3.setTitle(questionDictionary.answer3, forState: .Normal)
        answer4.setTitle(questionDictionary.answer4, forState: .Normal)
    }
    
    func displayScore() {
        // Hide the answer buttons
        answer1.hidden = true
        answer2.hidden = true
        answer3.hidden = true
        answer4.hidden = true
        
        // Display play again button
        playAgainButton.hidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    @IBAction func checkAnswer(sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        let selectedQuestionDict = trivia[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.correctAnswer
        
        
        if (sender.titleLabel?.text == correctAnswer) {
            playGameStartSound()
            correctQuestions += 1
            questionField.text = "Damn right!"
            
        } else {
            questionField.text = "Sorry, wrong answer!"
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        answer1.hidden = false
        answer2.hidden = false
        answer3.hidden = false
        answer4.hidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("frontlinerKick", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}

