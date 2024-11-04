//
//  Question.swift
//  QuizApp
//
//  Created by Ana Oganesiani on 03.11.24.
//

import Foundation

struct Question: Codable {
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
}
