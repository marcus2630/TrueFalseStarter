//
//  QuizModel.swift
//  TrueFalseStarter
//
//  Created by Marcus Klausen on 12/07/2016.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation


struct QuizModel {
    let question: String
    let correctAnswer: String
    let wrong1: String
    let wrong2: String
    let wrong3: String
    
    
    
    init(question: String, correctAnswer: String, wrong1: String, wrong2: String, wrong3: String) {
        self.question = question
        self.correctAnswer = correctAnswer
        self.wrong1 = wrong1
        self.wrong2 = wrong2
        self.wrong3 = wrong3
    }
    
}

var QuestionCollection = [
    QuizModel(question: "Defqon.1 anthem 2016 was done by:", correctAnswer: "Bass Modulators", wrong1:  "Coone", wrong2:  "Da Tweekaz", wrong3:  "Justin Bieber" ),
    QuizModel(question: "The artist behind \"Wolfpack\"?", correctAnswer: "Frequencerz", wrong1: "Headhunterz", wrong2: "Brennan Heart", wrong3: "D-Sturb")
]
                