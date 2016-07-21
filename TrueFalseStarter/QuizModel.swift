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
    let answer1: String
    let answer2: String
    let answer3: String
    let answer4: String
    
    
    
    init(question: String, correctAnswer: String, answer1: String, answer2: String, answer3: String, answer4: String) {
        self.question = question
        self.correctAnswer = correctAnswer
        self.answer1 = answer1
        self.answer2 = answer2
        self.answer3 = answer3
        self.answer4 = answer4
    }
    
}

var QuestionCollection = [
    QuizModel(question: "Defqon.1 anthem 2016 was made by...", correctAnswer: "Bass Modulators", answer1:  "Coone", answer2:  "Bass Modulators", answer3:  "Justin Bieber", answer4: "Da Tweekaz" ),
    QuizModel(question: "The artist behind superhit \"Wolfpack\"...", correctAnswer: "Frequencerz", answer1:  "Headhunterz", answer2:  "Brennan Heart", answer3:  "D-Sturb", answer4: "Frequencerz" ),
    QuizModel(question: "Hardwell has made a hardstyle collaboration with...", correctAnswer: "Sephyx", answer1:  "Sephyx", answer2:  "Adrenalize", answer3:  "Sylence", answer4: "Atmozfears" ),
    QuizModel(question: "Hardstyle is a genre originally influenced by Hardcore, Gabber and..", correctAnswer: "Trance", answer1:  "Dubstep", answer2:  "House", answer3:  "Trance", answer4: "Electro" )
]
                