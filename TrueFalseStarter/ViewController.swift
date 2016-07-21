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
    var trivia = QuestionCollection
    
    var gameend: SystemSoundID = 0
    var fail: SystemSoundID = 1
    var success: SystemSoundID = 2
    
    var usedQuestions = [Int]()
    
 
    
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
        loadGameFailSound()
        loadGameSuccessSound()
        displayQuestion()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func displayQuestion() {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(trivia.count)
        
        
        if usedQuestions.count == trivia.count {
            nextRound()
        } else if usedQuestions.contains(indexOfSelectedQuestion) {
            displayQuestion()
            
        } else {
            
            let questionDictionary = trivia[indexOfSelectedQuestion]
            questionField.text = questionDictionary.question
            playAgainButton.hidden = true
        
            answer1.setTitle(questionDictionary.answer1, forState: .Normal)
            answer2.setTitle(questionDictionary.answer2, forState: .Normal)
            answer3.setTitle(questionDictionary.answer3, forState: .Normal)
            answer4.setTitle(questionDictionary.answer4, forState: .Normal)
                
            // add question to used questions
            usedQuestions.append(indexOfSelectedQuestion)
            print("Debug question:  \(indexOfSelectedQuestion) used questions: \(usedQuestions)")
            }
        
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
            playSuccess()
            correctQuestions += 1
            questionField.text = "Damn right!"
            
        } else {
            questionField.text = "Sorry, wrong answer!"
            playFail()
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
            playGameStartSound()
            usedQuestions = [Int]()
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
        trivia = QuestionCollection
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
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("gameend", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameend)
    }
    
    func loadGameFailSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("fail", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &fail)
    }
    func loadGameSuccessSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("success", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &success)
    }
    
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameend)
    }
    func playFail() {
        AudioServicesPlaySystemSound(fail)
    }
    func playSuccess() {
        AudioServicesPlaySystemSound(success)
    }



}